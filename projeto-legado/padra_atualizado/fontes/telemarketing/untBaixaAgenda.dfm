inherited frmBaixaAgenda: TfrmBaixaAgenda
  Left = 252
  Top = 236
  Height = 372
  BorderStyle = bsDialog
  Caption = 'Baixa do Agendamento'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitHeight = 372
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 48
    Width = 114
    Height = 14
    Caption = 'Observa'#231#245'es da Baixa:'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 7
    Width = 32
    Height = 14
    Caption = 'Cliente'
  end
  object Label3: TLabel [2]
    Left = 360
    Top = 7
    Width = 109
    Height = 14
    Caption = 'Data do Agendamento:'
  end
  object lblTipAte: TLabel [3]
    Left = 8
    Top = 219
    Width = 97
    Height = 14
    Caption = 'Tipo de Atendimento'
  end
  inherited pnlBotoes: TPanel
    Top = 299
    TabOrder = 6
    ExplicitTop = 299
    inherited FlwBotoes: TFlowPanel
      Left = 218
      Width = 186
      TabOrder = 3
      ExplicitLeft = 218
      ExplicitWidth = 186
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Height = 24
      Align = alRight
      ModalResult = 2
      TabOrder = 2
      ExplicitLeft = 404
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 72
      Height = 24
      Align = alLeft
      Caption = '&Gravar'
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
      ModalResult = 1
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnPesqMerc: TBitBtnLocked
      Left = 74
      Top = 2
      Width = 144
      Height = 24
      Align = alLeft
      Caption = '[ F12 ] &Pesquisa de Mercado'
      TabOrder = 1
      OnClick = btnPesqMercClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 327
    TabOrder = 7
    ExplicitTop = 327
    inherited pnlNomeForm: TPanel
      TabOrder = 1
    end
    inherited pnlInfo: TPanel
      TabOrder = 0
    end
  end
  object dbmObsBai: TDBMemoFocus [6]
    Left = 8
    Top = 64
    Width = 465
    Height = 153
    DataField = 'AGE_OBSERV'
    DataSource = dscAgeTel
    ScrollBars = ssVertical
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  object pnlReagendar: TPanel [7]
    Left = 0
    Top = 262
    Width = 483
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
    object lblInformaPesquisaRealizada: TColorLabel
      Left = 191
      Top = 11
      Width = 154
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pesquisa de Mercado Realizada'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      CorDestaque = clRed
    end
    object chkReagendar: TCheckBox
      Left = 8
      Top = 10
      Width = 104
      Height = 17
      Caption = '&Reagendar para:'
      TabOrder = 0
      OnClick = chkReagendarClick
    end
    object mskDtaAge: TMaskEditFocus
      Tag = 99
      Left = 115
      Top = 7
      Width = 64
      Height = 22
      Enabled = False
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  object dbeCodTpa: TDBEditFocus [8]
    Tag = 99
    Left = 8
    Top = 234
    Width = 48
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AGE_CODTPA'
    DataSource = dscAgeTel
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 3
    OnKeyPress = dbeCodTpaKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttAlfanumerico
  end
  object edtDesTpa: TEditFocus [9]
    Left = 57
    Top = 234
    Width = 416
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 4
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object dbeNomCli: TDBEditFocus [10]
    Left = 8
    Top = 21
    Width = 346
    Height = 22
    DataField = 'CLI_NOMCLI'
    DataSource = frmAtendimento.dtsConsulta
    ReadOnly = True
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeDtaAge: TDBEditFocus [11]
    Left = 360
    Top = 21
    Width = 113
    Height = 22
    DataField = 'AGE_DTAAGE'
    DataSource = frmAtendimento.dtsConsulta
    ReadOnly = True
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 48
  end
  object dscAgeTel: TDataSource
    DataSet = qryAgeTel
    Left = 408
    Top = 112
  end
  object qryAgeTel: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT '
      '  * '
      'FROM '
      '  AGETEL'
      'WHERE '
      '  AUTOINCREM = :AUTOIN')
    Constraints = <>
    Left = 368
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AUTOIN'
        Value = nil
      end>
  end
end
