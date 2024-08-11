Pipeline riesgo de crédito
--------------------------

.. code:: ipython3

    import pandas as pd
    from sklearn.linear_model import LogisticRegression
    from sklearn.svm import SVC
    from sklearn.tree import DecisionTreeClassifier
    from sklearn.ensemble import (
        BaggingClassifier,
        RandomForestClassifier,
        AdaBoostClassifier,
        GradientBoostingClassifier,
        StackingClassifier,
    )
    from sklearn.pipeline import Pipeline
    from sklearn.preprocessing import StandardScaler
    from sklearn.model_selection import train_test_split, cross_val_score
    from sklearn.metrics import accuracy_score, confusion_matrix, classification_report
    import xgboost as xgb

.. code:: ipython3

    # Cargar el archivo CSV (ya lo hemos cargado y limpiado previamente)
    credit_risk_data = pd.read_csv("credit_risk_data.csv")
    credit_risk_data = credit_risk_data.drop(columns=["ID"])
    
    # Dividir los datos en características (X) y etiqueta (y)
    X = credit_risk_data.drop(columns=["Estado del Préstamo"])
    y = credit_risk_data["Estado del Préstamo"]
    
    # Dividir el conjunto de datos en entrenamiento y prueba
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=34)

Creación de los modelos:
~~~~~~~~~~~~~~~~~~~~~~~~

``Pipeline()``

.. code:: ipython3

    models = {
        "Logistic Regression": Pipeline(
            [
                ("scaler", StandardScaler()),
                ("classifier", LogisticRegression(max_iter=1000)),
            ]
        ),
        "SVM": Pipeline(
            [
                ("scaler", StandardScaler()),
                ("classifier", SVC(kernel="rbf", probability=True)),
            ]
        ),
        "Decision Tree": Pipeline(
            [
                ("scaler", StandardScaler()),
                (
                    "classifier",
                    DecisionTreeClassifier(
                        max_depth=3, min_samples_split=5, min_samples_leaf=2
                    ),
                ),
            ]
        ),
        "Bagging": Pipeline(
            [
                ("scaler", StandardScaler()),
                (
                    "classifier",
                    BaggingClassifier(
                        base_estimator=DecisionTreeClassifier(),
                        n_estimators=100,
                        max_samples=0.8,
                        bootstrap=True,
                        n_jobs=-1,
                        random_state=42,
                    ),
                ),
            ]
        ),
        "Random Forest": Pipeline(
            [
                ("scaler", StandardScaler()),
                (
                    "classifier",
                    RandomForestClassifier(
                        n_estimators=100,
                        max_depth=3,
                        max_features="sqrt",
                        random_state=42,
                        n_jobs=-1,
                    ),
                ),
            ]
        ),
        "AdaBoost": Pipeline(
            [
                ("scaler", StandardScaler()),
                (
                    "classifier",
                    AdaBoostClassifier(
                        base_estimator=DecisionTreeClassifier(max_depth=1),
                        n_estimators=100,
                        learning_rate=0.1,
                        random_state=42,
                    ),
                ),
            ]
        ),
        "Gradient Boosting": Pipeline(
            [
                ("scaler", StandardScaler()),
                (
                    "classifier",
                    GradientBoostingClassifier(
                        n_estimators=100, max_depth=3, learning_rate=0.1, random_state=42
                    ),
                ),
            ]
        ),
        "XGBoost": Pipeline(
            [
                ("scaler", StandardScaler()),
                (
                    "classifier",
                    xgb.XGBClassifier(
                        n_estimators=100,
                        max_depth=3,
                        learning_rate=0.1,
                        subsample=0.8,
                        colsample_bytree=0.8,
                        random_state=42,
                    ),
                ),
            ]
        ),
        "Stacking": Pipeline(
            [
                ("scaler", StandardScaler()),
                (
                    "classifier",
                    StackingClassifier(
                        estimators=[
                            ("svc", SVC(probability=True)),
                            (
                                "rf",
                                RandomForestClassifier(n_estimators=100, random_state=42),
                            ),
                            ("dt", DecisionTreeClassifier(random_state=42)),
                            ("log_reg", LogisticRegression(max_iter=1000)),
                        ],
                        final_estimator=LogisticRegression(),
                        cv=5,
                    ),
                ),
            ]
        ),
    }

.. code:: ipython3

    # Evaluar cada modelo
    accuracies = {}
    for name, pipeline in models.items():
        # Validación cruzada para obtener la media de la precisión
        cv_scores = cross_val_score(pipeline, X_train, y_train, cv=10, scoring="accuracy")
        mean_cv_score = cv_scores.mean()
    
        # Entrenar el modelo y predecir en el conjunto de prueba
        pipeline.fit(X_train, y_train)
        y_pred = pipeline.predict(X_test)
    
        # Calcular la precisión en el conjunto de prueba
        test_accuracy = accuracy_score(y_test, y_pred)
    
        # Guardar las precisiones
        accuracies[name] = {
            "CV Accuracy": mean_cv_score,
            "Test Accuracy": test_accuracy,
            "Confusion Matrix": confusion_matrix(y_test, y_pred),
            "Classification Report": classification_report(y_test, y_pred),
        }
    
    # Mostrar los resultados
    for model_name, metrics in accuracies.items():
        print(f"Model: {model_name}")
        print(f"Cross-Validation Accuracy: {metrics['CV Accuracy']:.2f}")
        print(f"Test Accuracy: {metrics['Test Accuracy']:.2f}")
        print("Confusion Matrix:")
        print(metrics["Confusion Matrix"])
        print("Classification Report:")
        print(metrics["Classification Report"])
        print("\n" + "-" * 40 + "\n")


.. parsed-literal::

    Model: Logistic Regression
    Cross-Validation Accuracy: 0.88
    Test Accuracy: 0.87
    Confusion Matrix:
    [[ 46  27]
     [ 12 215]]
    Classification Report:
                  precision    recall  f1-score   support
    
               0       0.79      0.63      0.70        73
               1       0.89      0.95      0.92       227
    
        accuracy                           0.87       300
       macro avg       0.84      0.79      0.81       300
    weighted avg       0.87      0.87      0.86       300
    
    
    ----------------------------------------
    
    Model: SVM
    Cross-Validation Accuracy: 0.94
    Test Accuracy: 0.93
    Confusion Matrix:
    [[ 57  16]
     [  6 221]]
    Classification Report:
                  precision    recall  f1-score   support
    
               0       0.90      0.78      0.84        73
               1       0.93      0.97      0.95       227
    
        accuracy                           0.93       300
       macro avg       0.92      0.88      0.90       300
    weighted avg       0.93      0.93      0.92       300
    
    
    ----------------------------------------
    
    Model: Decision Tree
    Cross-Validation Accuracy: 0.92
    Test Accuracy: 0.92
    Confusion Matrix:
    [[ 55  18]
     [  7 220]]
    Classification Report:
                  precision    recall  f1-score   support
    
               0       0.89      0.75      0.81        73
               1       0.92      0.97      0.95       227
    
        accuracy                           0.92       300
       macro avg       0.91      0.86      0.88       300
    weighted avg       0.92      0.92      0.91       300
    
    
    ----------------------------------------
    
    Model: Bagging
    Cross-Validation Accuracy: 0.98
    Test Accuracy: 0.98
    Confusion Matrix:
    [[ 70   3]
     [  3 224]]
    Classification Report:
                  precision    recall  f1-score   support
    
               0       0.96      0.96      0.96        73
               1       0.99      0.99      0.99       227
    
        accuracy                           0.98       300
       macro avg       0.97      0.97      0.97       300
    weighted avg       0.98      0.98      0.98       300
    
    
    ----------------------------------------
    
    Model: Random Forest
    Cross-Validation Accuracy: 0.88
    Test Accuracy: 0.86
    Confusion Matrix:
    [[ 30  43]
     [  0 227]]
    Classification Report:
                  precision    recall  f1-score   support
    
               0       1.00      0.41      0.58        73
               1       0.84      1.00      0.91       227
    
        accuracy                           0.86       300
       macro avg       0.92      0.71      0.75       300
    weighted avg       0.88      0.86      0.83       300
    
    
    ----------------------------------------
    
    Model: AdaBoost
    Cross-Validation Accuracy: 0.98
    Test Accuracy: 0.97
    Confusion Matrix:
    [[ 67   6]
     [  2 225]]
    Classification Report:
                  precision    recall  f1-score   support
    
               0       0.97      0.92      0.94        73
               1       0.97      0.99      0.98       227
    
        accuracy                           0.97       300
       macro avg       0.97      0.95      0.96       300
    weighted avg       0.97      0.97      0.97       300
    
    
    ----------------------------------------
    
    Model: Gradient Boosting
    Cross-Validation Accuracy: 0.98
    Test Accuracy: 0.99
    Confusion Matrix:
    [[ 71   2]
     [  2 225]]
    Classification Report:
                  precision    recall  f1-score   support
    
               0       0.97      0.97      0.97        73
               1       0.99      0.99      0.99       227
    
        accuracy                           0.99       300
       macro avg       0.98      0.98      0.98       300
    weighted avg       0.99      0.99      0.99       300
    
    
    ----------------------------------------
    
    Model: XGBoost
    Cross-Validation Accuracy: 0.99
    Test Accuracy: 0.99
    Confusion Matrix:
    [[ 71   2]
     [  1 226]]
    Classification Report:
                  precision    recall  f1-score   support
    
               0       0.99      0.97      0.98        73
               1       0.99      1.00      0.99       227
    
        accuracy                           0.99       300
       macro avg       0.99      0.98      0.99       300
    weighted avg       0.99      0.99      0.99       300
    
    
    ----------------------------------------
    
    Model: Stacking
    Cross-Validation Accuracy: 0.98
    Test Accuracy: 0.99
    Confusion Matrix:
    [[ 71   2]
     [  2 225]]
    Classification Report:
                  precision    recall  f1-score   support
    
               0       0.97      0.97      0.97        73
               1       0.99      0.99      0.99       227
    
        accuracy                           0.99       300
       macro avg       0.98      0.98      0.98       300
    weighted avg       0.99      0.99      0.99       300
    
    
    ----------------------------------------
    
    

**Validación cruzada:**

Se utiliza ``cross_val_score`` para realizar validación cruzada con 10
divisiones (``cv=10``) en el conjunto de entrenamiento. Esto proporciona
una medida de la precisión promedio (``mean_cv_score``) obtenida en
múltiples particiones de los datos.

La validación cruzada es útil para evaluar la estabilidad y la
generalización del modelo, asegurando que no se sobreajuste a una sola
división de los datos.
