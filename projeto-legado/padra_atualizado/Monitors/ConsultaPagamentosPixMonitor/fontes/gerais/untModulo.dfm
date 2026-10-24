object frmModulo: TfrmModulo
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 528
  Width = 325
  object Database: TUniConnection
    ProviderName = 'MySQL'
    Port = 3306
    LoginPrompt = False
    AfterConnect = DatabaseAfterConnect
    OnError = DatabaseError
    Left = 24
    Top = 8
    EncryptedPassword = '9CFF96FF8BFF9AFF93FFCEFFCCFFCCFFCBFFC8FF'
  end
  object qryCnfBol: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT '
      '  *'
      'FROM '
      '  CNFBOL '
      'ORDER BY '
      '  CNF_CODBCO, '
      '  CNF_IDENTI, '
      '  CNF_LINIMP, '
      '  CNF_COLIMP')
    Constraints = <>
    Left = 24
    Top = 240
    object qryCnfBolCNF_CODBCO: TStringField
      DisplayLabel = 'Banco'
      FieldName = 'CNF_CODBCO'
      Size = 3
    end
    object qryCnfBolCNF_IDENTI: TStringField
      DisplayLabel = 'ID'
      FieldName = 'CNF_IDENTI'
      Size = 2
    end
    object qryCnfBolCNF_LINIMP: TIntegerField
      DisplayLabel = 'Linha'
      FieldName = 'CNF_LINIMP'
    end
    object qryCnfBolCNF_COLIMP: TIntegerField
      DisplayLabel = 'Coluna'
      FieldName = 'CNF_COLIMP'
    end
    object qryCnfBolCNF_MARGEM: TIntegerField
      DisplayLabel = 'Margem'
      FieldName = 'CNF_MARGEM'
    end
    object qryCnfBolCNF_CHRANT: TStringField
      DisplayLabel = 'Chr Antes'
      FieldName = 'CNF_CHRANT'
      Size = 50
    end
    object qryCnfBolCNF_DESCAM: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'CNF_DESCAM'
      Size = 250
    end
    object qryCnfBolCNF_CHRDEP: TStringField
      DisplayLabel = 'Chr Depois'
      FieldName = 'CNF_CHRDEP'
      Size = 50
    end
    object qryCnfBolAUTOINCREM: TIntegerField
      FieldName = 'AUTOINCREM'
    end
    object qryCnfBolCNF_CODEMP: TStringField
      FieldName = 'CNF_CODEMP'
      Size = 3
    end
  end
  object dtsCnfBol: TDataSource
    Left = 96
    Top = 240
  end
  object qryCnfEti: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM CNFETI'
      'ORDER BY CNF_TIPETI, CNF_IDENTI, CNF_LINIMP, CNF_COL001')
    Constraints = <>
    Left = 23
    Top = 302
    object qryCnfEtiCNF_TIPETI: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'CNF_TIPETI'
      Size = 3
    end
    object qryCnfEtiCNF_IDENTI: TStringField
      DisplayLabel = 'Identi'
      FieldName = 'CNF_IDENTI'
      Size = 2
    end
    object qryCnfEtiCNF_LINIMP: TIntegerField
      DisplayLabel = 'Linha'
      FieldName = 'CNF_LINIMP'
    end
    object qryCnfEtiCNF_COL001: TIntegerField
      DisplayLabel = 'Coluna 001'
      FieldName = 'CNF_COL001'
    end
    object qryCnfEtiCNF_COL002: TIntegerField
      DisplayLabel = 'Coluna 002'
      FieldName = 'CNF_COL002'
    end
    object qryCnfEtiCNF_COL003: TIntegerField
      DisplayLabel = 'Coluna 003'
      FieldName = 'CNF_COL003'
    end
    object qryCnfEtiCNF_COL004: TIntegerField
      DisplayLabel = 'Coluna 004'
      FieldName = 'CNF_COL004'
    end
    object qryCnfEtiCNF_COL005: TIntegerField
      DisplayLabel = 'Coluna 005'
      FieldName = 'CNF_COL005'
    end
    object qryCnfEtiCNF_MARGEM: TIntegerField
      DisplayLabel = 'Margem'
      FieldName = 'CNF_MARGEM'
    end
    object qryCnfEtiCNF_QTDCOL: TIntegerField
      DisplayLabel = 'Qtd. Colunas'
      FieldName = 'CNF_QTDCOL'
    end
    object qryCnfEtiCNF_CHRANT: TStringField
      DisplayLabel = 'Chr. Antes'
      FieldName = 'CNF_CHRANT'
      Size = 50
    end
    object qryCnfEtiCNF_CHRDEP: TStringField
      DisplayLabel = 'Crh. Depois'
      FieldName = 'CNF_CHRDEP'
      Size = 50
    end
    object qryCnfEtiAUTOINCREM: TIntegerField
      FieldName = 'AUTOINCREM'
    end
    object qryCnfEtiCNF_DESCAM: TStringField
      FieldName = 'CNF_DESCAM'
      Size = 250
    end
    object qryCnfEtiCNF_LINTOP: TIntegerField
      FieldName = 'CNF_LINTOP'
    end
    object qryCnfEtiCNF_CODEMP: TStringField
      FieldName = 'CNF_CODEMP'
      Size = 3
    end
  end
  object dtsCnfEti: TDataSource
    Left = 96
    Top = 302
  end
  object qryCadGpo: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM CADGPO')
    Constraints = <>
    Left = 184
    Top = 64
    object qryCadGpoGPO_CODGPO: TIntegerField
      DisplayLabel = 'Grupo'
      FieldName = 'GPO_CODGPO'
    end
    object qryCadGpoGPO_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'GPO_DESCRI'
      Size = 50
    end
    object qryCadGpoGPO_DTACAD: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'GPO_DTACAD'
    end
    object qryCadGpoGPO_CODEMP: TStringField
      FieldName = 'GPO_CODEMP'
      Size = 3
    end
    object qryCadGpoAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object qryOpeGpo: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM OPEGPO')
    Constraints = <>
    Left = 184
    Top = 120
    object qryOpeGpoOPE_CODOPE: TStringField
      FieldName = 'OPE_CODOPE'
      Size = 3
    end
    object qryOpeGpoGPO_CODGPO: TIntegerField
      FieldName = 'GPO_CODGPO'
    end
  end
  object tblGruOpe: TUniTable
    TableName = 'OPEGPO'
    Connection = Database
    MasterFields = 'GPO_CODGPO'
    Constraints = <>
    IndexFieldNames = 'GPO_CODGPO Asc'
    OnCalcFields = tblGruOpeCalcFields
    Left = 184
    Top = 176
    object tblGruOpeOPE_CODOPE: TStringField
      FieldName = 'OPE_CODOPE'
      Size = 3
    end
    object tblGruOpeGPO_CODGPO: TIntegerField
      FieldName = 'GPO_CODGPO'
    end
    object cdsGruOpeOPE_DESCRI: TStringField
      FieldKind = fkCalculated
      FieldName = 'OPE_DESCRI'
      Size = 30
      Calculated = True
    end
  end
  object qryDirGpo: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM DIRGPO')
    Constraints = <>
    AfterPost = qryDirGpoAfterPost
    BeforeDelete = qryDirGpoBeforeDelete
    Left = 184
    Top = 232
    object qryDirGpoDIR_NOMFRM: TStringField
      FieldName = 'DIR_NOMFRM'
      Size = 50
    end
    object qryDirGpoGPO_CODGPO: TIntegerField
      FieldName = 'GPO_CODGPO'
    end
    object qryDirGpoDIR_ACAOUS: TStringField
      FieldName = 'DIR_ACAOUS'
      Size = 3
    end
  end
  object qryDirOpe: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM DIROPE')
    Constraints = <>
    AfterPost = qryDirOpeAfterPost
    BeforeDelete = qryDirOpeBeforeDelete
    Left = 184
    Top = 288
    object qryDirOpeDIR_NOMFRM: TStringField
      FieldName = 'DIR_NOMFRM'
      Required = True
      Size = 50
    end
    object qryDirOpeOPE_CODOPE: TStringField
      FieldName = 'OPE_CODOPE'
      Required = True
      Size = 3
    end
    object qryDirOpeDIR_ACAOUS: TStringField
      FieldName = 'DIR_ACAOUS'
      Size = 3
    end
  end
  object dtsCadGpo: TDataSource
    Left = 264
    Top = 64
  end
  object dtsOpeGpo: TDataSource
    Left = 264
    Top = 120
  end
  object dtsDirGpo: TDataSource
    Left = 264
    Top = 232
  end
  object dtsDirOpe: TDataSource
    Left = 264
    Top = 288
  end
  object dtsGruOpe: TDataSource
    Left = 264
    Top = 176
  end
  object qryDirBan: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM DIRBAN')
    Constraints = <>
    AfterPost = qryDirBanAfterPost
    BeforeDelete = qryDirBanBeforeDelete
    Left = 176
    Top = 416
  end
  object dtsDirBan: TDataSource
    Left = 256
    Top = 416
  end
  object qryCnf_Nf: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT '
      '  *'
      'FROM '
      '  CNF_NF'
      'WHERE '
      '  CNF_TIPNOT   = :TIPNOT AND '
      '  CNF_CODEMP = :CODEMP '
      'ORDER BY '
      '  CNF_IDENTI, '
      '  CNF_LINIMP, '
      '  CNF_COLIMP,'
      '  CNF_CODSEQ')
    Constraints = <>
    Left = 24
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TIPNOT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CODEMP'
        Value = nil
      end>
    object qryCnf_NfCNF_CODSEQ: TIntegerField
      DisplayLabel = 'Sequencial'
      FieldName = 'CNF_CODSEQ'
    end
    object qryCnf_NfCNF_LINTOP: TIntegerField
      FieldName = 'CNF_LINTOP'
    end
    object qryCnf_NfCNF_MARGEM: TIntegerField
      DisplayLabel = 'Margem'
      FieldName = 'CNF_MARGEM'
    end
    object qryCnf_NfCNF_TIPNOT: TStringField
      DisplayLabel = 'Tipo de Nota'
      FieldName = 'CNF_TIPNOT'
      Size = 2
    end
    object qryCnf_NfCNF_IDENTI: TStringField
      DisplayLabel = 'ID'
      FieldName = 'CNF_IDENTI'
      Size = 2
    end
    object qryCnf_NfCNF_LINTIP: TStringField
      FieldName = 'CNF_LINTIP'
      Size = 2
    end
    object qryCnf_NfCNF_DESDOB: TStringField
      DisplayLabel = 'Desdobro'
      FieldName = 'CNF_DESDOB'
      Size = 1
    end
    object qryCnf_NfCNF_LINIMP: TIntegerField
      DisplayLabel = 'Linha'
      FieldName = 'CNF_LINIMP'
    end
    object qryCnf_NfCNF_COLIMP: TIntegerField
      DisplayLabel = 'Coluna'
      FieldName = 'CNF_COLIMP'
    end
    object qryCnf_NfCNF_CHRANT: TStringField
      DisplayLabel = 'Chr anterior'
      FieldName = 'CNF_CHRANT'
      Size = 25
    end
    object qryCnf_NfCNF_CHRDEP: TStringField
      DisplayLabel = 'Chr Posterior'
      FieldName = 'CNF_CHRDEP'
      Size = 25
    end
    object qryCnf_NfCNF_LITOPO: TIntegerField
      FieldName = 'CNF_LITOPO'
    end
    object qryCnf_NfCNF_CODEMP: TStringField
      FieldName = 'CNF_CODEMP'
      Size = 3
    end
    object qryCnf_NfCNF_DESCAM: TStringField
      FieldName = 'CNF_DESCAM'
      Size = 250
    end
  end
  object dtsCnf_Nf: TDataSource
    Left = 88
    Top = 368
  end
  object qryDirTin: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM DIRTIN')
    Constraints = <>
    AfterPost = qryDirTinAfterPost
    BeforeDelete = qryDirTinBeforeDelete
    Left = 184
    Top = 352
  end
  object dtsDirTin: TDataSource
    Left = 256
    Top = 352
  end
  object qryLogErr: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM LOGERR WHERE FALSE')
    Constraints = <>
    Left = 24
    Top = 176
  end
  object dtsLogErr: TDataSource
    DataSet = qryLogErr
    Left = 96
    Top = 176
  end
  object qryProCod: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM PROCOD')
    Constraints = <>
    Left = 24
    Top = 64
    object qryProCodPRO_NOMARQ: TStringField
      DisplayLabel = 'Arquivo'
      DisplayWidth = 15
      FieldName = 'PRO_NOMARQ'
      Size = 15
    end
    object qryProCodPRO_CODSEQ: TStringField
      DisplayLabel = 'Prox. C'#243'digo'
      FieldName = 'PRO_CODSEQ'
      Size = 12
    end
    object qryProCodPRO_TAMCOD: TIntegerField
      DisplayLabel = 'Tamanho do C'#243'digo'
      FieldName = 'PRO_TAMCOD'
    end
    object qryProCodPRO_CODAUT: TStringField
      DisplayLabel = 'Autom'#225'tico?'
      FieldName = 'PRO_CODAUT'
      Size = 1
    end
    object qryProCodPRO_CODEMP: TStringField
      DisplayLabel = 'C'#243'digo Empresa'
      FieldName = 'PRO_CODEMP'
      Visible = False
      Size = 3
    end
    object qryProCodAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryProCodPRO_SEQEMP: TStringField
      FieldName = 'PRO_SEQEMP'
    end
  end
  object dtsProCod: TDataSource
    Left = 96
    Top = 64
  end
  object MadException: TMadExceptionHandler
    OnException = MadExceptionException
    Left = 96
    Top = 8
  end
  object qryLogDir: TUniQuery
    Connection = Database
    SQL.Strings = (
      'SELECT * FROM LOGDIR WHERE FALSE')
    Constraints = <>
    Left = 176
    Top = 480
  end
  object DataDBF: TUniConnection
    ProviderName = 'DBF'
    LoginPrompt = False
    Left = 96
    Top = 120
  end
end
