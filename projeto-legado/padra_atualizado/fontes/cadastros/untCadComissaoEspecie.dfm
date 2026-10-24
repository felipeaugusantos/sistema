inherited frmCadComissaoEspecie: TfrmCadComissaoEspecie
  Height = 479
  Caption = 
    'Cadastro de Comiss'#227'o por Esp'#233'cie de Documento e Forma de Pagamen' +
    'to'
  ExplicitTop = -44
  ExplicitHeight = 479
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 105
    ExplicitTop = 105
    inherited FlwBotoes: TFlowPanel
      Align = alLeft
      ExplicitWidth = 182
    end
    inherited btnCancela: TBitBtnLocked
      Left = 359
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 270
      ExplicitLeft = 248
      ExplicitTop = -4
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 180
    end
    inherited btnGravar: TBitBtnLocked
      Left = 91
      ExplicitLeft = 56
      ExplicitTop = 6
    end
    inherited btnIncluir: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
      ExplicitTop = -2
    end
  end
  inherited pnlHeader: TPanel
    Height = 65
    ExplicitHeight = 65
    inherited lblInf: TLabel
      Top = 11
      ExplicitTop = 11
    end
    object Label57: TLabel [1]
      Left = 7
      Top = 36
      Width = 113
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie do Documento:'
    end
    object Label2: TLabel [2]
      Left = 16
      Top = 11
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'Forma de Pagamento:'
    end
    object lblTipCar: TLabel [3]
      Left = 174
      Top = 36
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Cart'#227'o:'
      Enabled = False
    end
    object Label4: TLabel [4]
      Left = 354
      Top = 36
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = '% Comiss'#227'o:'
    end
    inherited pgcDados: TPageControl
      TabOrder = 4
      inherited tbsGeral: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 28
        ExplicitWidth = 57
        ExplicitHeight = 15
      end
    end
    object dbeEspDoc: TDBEditFocus
      Tag = 99
      Left = 122
      Top = 32
      Width = 23
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'COM_ESPDOC'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipCar: TDBComboBoxFocus
      Tag = 99
      Left = 248
      Top = 32
      Width = 83
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'COM_TIPCAR'
      DataSource = dtsConsulta
      Enabled = False
      Items.Strings = (
        'Cr'#233'dito'
        'D'#233'bito')
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeValCom: TDBEditFocus
      Tag = 99
      Left = 420
      Top = 32
      Width = 82
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'COM_VALCOM'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodFpg: TDBLookupComboBoxFocus
      Tag = 99
      Left = 122
      Top = 7
      Width = 209
      Height = 22
      DataField = 'COM_CODFPG'
      DataSource = dtsConsulta
      KeyField = 'FPG_CODIGO'
      ListField = 'FPG_DESCRI'
      ListSource = dtsCadFpg
      TabOrder = 0
      OnClick = dbeCodFpgClick
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlTail: TPanel
    Top = 349
    ExplicitTop = 349
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 133
    Height = 216
    Columns = <
      item
        Expanded = False
        FieldName = 'COM_ESPDOC'
        Title.Caption = 'Esp'#233'cie'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FPG_DESCRI'
        Title.Caption = 'Forma de Pagamento'
        Width = 225
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COM_TIPCAR'
        Title.Caption = 'C/D'
        Width = 24
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COM_VALCOM'
        Title.Alignment = taRightJustify
        Title.Caption = '% Comiss'#227'o'
        Width = 70
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 65
    ExplicitTop = 65
    inherited lblPesquisa: TLabel
      Top = 12
      ExplicitTop = 12
    end
    inherited lblNomeCampo: TLabel
      Top = 12
      ExplicitTop = 12
    end
  end
  inherited pnlInfBotoes: TPanel
    Top = 398
    ExplicitTop = 398
    inherited Label1: TLabel
      Width = 713
      Height = 22
    end
  end
  inherited pnlStatus: TPanel
    Top = 424
    ExplicitTop = 424
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 72
  end
  inherited qryConsulta: TUniQuery
    Top = 240
  end
  inherited dspConsulta: TUniDataSetProvider
    ResolveToDataSet = True
    Top = 240
  end
  inherited cdsConsulta: TUniClientDataSet
    Top = 240
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsConsultaCOM_ESPDOC: TStringField
      FieldName = 'COM_ESPDOC'
      Size = 2
    end
    object cdsConsultaCOM_CODFPG: TStringField
      FieldName = 'COM_CODFPG'
      Size = 3
    end
    object cdsConsultaCOM_TIPCAR: TStringField
      FieldName = 'COM_TIPCAR'
      Size = 1
    end
    object cdsConsultaCOM_VALCOM: TFloatField
      DisplayWidth = 10
      FieldName = 'COM_VALCOM'
    end
    object cdsConsultaFPG_DESCRI: TStringField
      FieldKind = fkLookup
      FieldName = 'FPG_DESCRI'
      LookupDataSet = qryCadFpg
      LookupKeyFields = 'FPG_CODIGO'
      LookupResultField = 'FPG_DESCRI'
      KeyFields = 'COM_CODFPG'
      Size = 50
      Lookup = True
    end
  end
  inherited dtsConsulta: TDataSource
    Top = 240
  end
  object qryCadFpg: TUniQuery
    Constraints = <>
    Left = 456
    Top = 248
    object qryCadFpgFPG_CODIGO: TStringField
      FieldName = 'FPG_CODIGO'
    end
    object qryCadFpgFPG_DESCRI: TStringField
      DisplayWidth = 50
      FieldName = 'FPG_DESCRI'
      Size = 50
    end
  end
  object dtsCadFpg: TDataSource
    DataSet = qryCadFpg
    Left = 424
    Top = 248
  end
end
