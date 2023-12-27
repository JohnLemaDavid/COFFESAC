import 'package:sqfentity_gen/sqfentity_gen.dart';

const tableConfig = SqfEntityTable(
    tableName: 'config',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('clave', DbType.text),
      SqfEntityField('valor', DbType.text),
    ]
);
const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);
@SqfEntityBuilder(coffeeSacDBModel)
const coffeeSacDBModel = SqfEntityModel(
    modelName: 'coffeeSacDBModel', // optional
    databaseName: 'coffeeSac.db',
    databaseTables: [tableConfig],
    sequences: [seqIdentity],
    bundledDatabasePath: null
);