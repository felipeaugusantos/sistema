inherited frmGerInventario: TfrmGerInventario
  Left = 356
  Top = 271
  Width = 335
  Height = 538
  Caption = 'Invent'#225'rio F'#237'sico'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 335
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 6
    Top = 5
    Width = 66
    Height = 14
    Alignment = taRightJustify
    Caption = 'Arquivo Base'
  end
  object Label2: TLabel [1]
    Left = 6
    Top = 293
    Width = 54
    Height = 14
    Alignment = taRightJustify
    Caption = 'Data Inicial:'
  end
  object Label3: TLabel [2]
    Left = 141
    Top = 293
    Width = 50
    Height = 14
    Alignment = taRightJustify
    Caption = 'Data Final:'
  end
  object lblEmpresa: TLabel [3]
    Left = 5
    Top = 255
    Width = 48
    Height = 14
    Caption = 'Empresa.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 465
    Width = 329
    TabOrder = 9
    ExplicitTop = 465
    ExplicitWidth = 329
    DesignSize = (
      329
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 325
      TabOrder = 4
      ExplicitWidth = 325
    end
    inherited btnSair: TBitBtnLocked
      Left = 250
      TabOrder = 3
      ExplicitLeft = 250
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Gerar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnCopiar: TBitBtnLocked
      Left = 80
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Copiar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF056695056695FF00FFFF00FFFF00FFFF00FFFF00FF05
        6695056695056695056695056695056695056695FF00FFFF00FF056695359FD5
        0D6F9DFF00FF162830FF00FF162830155F819FD4EEA1D1EB0262905DA9CBACD8
        F0056695FF00FFFF00FF05669573C0E73596C14E68723956621B44582C4F6016
        7DADB6DDF0BDE1F3015F907FBBD7E7F7FE056695FF00FFFF00FF056695A9D3E6
        056695162830FF00FF162830FF00FF05699A5FB5E005669502629005669573C2
        EB056695FF00FFFF00FF056695016090FF00FFFF00FFFF00FFFF00FF1075A549
        A1CB056695FF00FFFF00FFFF00FF05669545A0CC056695FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF056695A6D4E7056695FF00FFFF00FFFF00FFFF00FFFF00
        FF0566959DCFE6056695FF00FFFF00FFFF00FFFF00FFFF00FF056695CAE5EE05
        6695FF00FFA46769A46769A46769FF00FF006497D1E9F0056695FF00FFFF00FF
        FF00FFFF00FFFF00FF056695B2DCEA056695FF00FFA46769EDC795A46769FF00
        FF006698BDE1ED056695FF00FFFF00FFFF00FFFF00FFFF00FF056695A4D7E605
        6695FF00FFA46769F8E0ADA46769FF00FF006698ACDAEA056695FF00FFFF00FF
        FF00FFFF00FFFF00FF056695ADDCEB056695FF00FFA7756BFBE6C0A46769FF00
        FF006698B0DDEB056695FF00FFFF00FFFF00FFFF00FFFF00FF0566955CAAC605
        6695FF00FFBC8268FFEFD7A46769FF00FF02699C83C1D8056695FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF056695056695FF00FFD1926DFFFCEEA46769FF00
        FF056797096B99FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFDA9D75F2E7E1A56B5FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79C07849FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFD1926DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnCopiarClick
    end
    object btnExcluir: TBitBtnLocked
      Left = 157
      Top = 3
      Width = 78
      Height = 22
      Caption = '&Excluir'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
        00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
        00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
        DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
        006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
        16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
        20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
        00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
        00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
        E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnExcluirClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 493
    Width = 329
    TabOrder = 11
    ExplicitTop = 493
    ExplicitWidth = 329
    inherited pnlNomeForm: TPanel
      Left = 158
      ExplicitLeft = 158
    end
    inherited pnlInfo: TPanel
      Width = 158
      ExplicitWidth = 158
    end
  end
  object mskDtaIni: TMaskEditFocus [6]
    Left = 6
    Top = 309
    Width = 110
    Height = 22
    EditMask = '!99/99/9999;1;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object mskDtaFin: TMaskEditFocus [7]
    Left = 141
    Top = 309
    Width = 110
    Height = 22
    EditMask = '!99/99/9999;1;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 3
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object chkInverter: TCheckBox [8]
    Left = 6
    Top = 333
    Width = 250
    Height = 15
    Hint = 
      'Apartir do saldo do arquivo base, as movimenta'#231#245'es de saida s'#227'o ' +
      'SOMADAS ao saldo e as Entradas s'#227'o SUBTRAIDAS do saldo inicial'
    Caption = 'Gerar Invent'#225'rio de data Anterior ao Arq. Base'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = chkInverterClick
  end
  object rdbEntFut: TRadioGroup [9]
    Left = 2
    Top = 402
    Width = 317
    Height = 57
    Caption = 'Considerar a baixa do estoque da Entrega Futura pela:'
    ItemIndex = 1
    Items.Strings = (
      'CFOP 5922/6922, gerada pelo faturamento'
      'CFOP 5117(6)/6117(6), gerada pela baixa de entrega futura')
    TabOrder = 8
  end
  object chkSumNeg: TCheckBox [10]
    Left = 6
    Top = 351
    Width = 265
    Height = 15
    Caption = 'Somar Negativos (Como Positivo) no Arquivo Base'
    TabOrder = 5
    OnClick = chkSumNegClick
  end
  object chkOrdInd: TCheckBox [11]
    Left = 6
    Top = 367
    Width = 240
    Height = 15
    Caption = 'Considerar ordem de produ'#231#227'o industrial (OI)'
    TabOrder = 6
  end
  object chkOrdPro: TCheckBox [12]
    Left = 6
    Top = 384
    Width = 240
    Height = 15
    Caption = 'Considerar ordem de produ'#231#227'o (OP)'
    TabOrder = 7
  end
  object edtCodEmpresa: TEditFocus [13]
    Tag = 99
    Left = 5
    Top = 270
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentFont = False
    TabOrder = 1
    OnExit = edtCodEmpresaExit
    OnKeyPress = edtCodEmpresaKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtDesEmpresa: TEditFocus [14]
    Left = 66
    Top = 270
    Width = 254
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 10
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object cxgArqs: TcxGrid [15]
    Left = 6
    Top = 20
    Width = 313
    Height = 227
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvArqs: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum arquivo encontrado>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      object cxvArqsMARCAR: TcxGridDBColumn
        Caption = 'Marcar'
        DataBinding.FieldName = 'MARCAR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 47
      end
      object cxvArqsNomArq: TcxGridDBColumn
        Caption = 'Arquivo'
        DataBinding.FieldName = 'NOMARQ'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 264
      end
    end
    object cxgArqsLevel1: TcxGridLevel
      GridView = cxvArqs
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 216
    Top = 32
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 15329769
    end
  end
end
