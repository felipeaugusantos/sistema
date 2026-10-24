inherited frmDirEsp: TfrmDirEsp
  Left = 307
  Top = 302
  Width = 437
  Height = 234
  HorzScrollBar.Range = 421
  VertScrollBar.Range = 200
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 437
  ExplicitHeight = 234
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 99
    Top = 7
    Width = 94
    Height = 14
    Caption = 'Nome do Operador:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lblLogin: TLabel [1]
    Left = 7
    Top = 7
    Width = 78
    Height = 14
    Caption = 'Login Operador:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lblNomForm: TLabel [2]
    Left = 46
    Top = 56
    Width = 2
    Height = 9
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSkyBlue
    Font.Height = 9
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 161
    Width = 431
    ExplicitTop = 161
    ExplicitWidth = 431
    inherited FlwBotoes: TFlowPanel
      Left = 116
      Width = 236
      TabOrder = 2
      ExplicitWidth = 427
    end
    inherited btnSair: TBitBtnLocked
      Left = 352
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 348
    end
    object btnMarcar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 114
      Height = 24
      Hint = 'Marcar/Desmarcar Todos'
      Align = alLeft
      Caption = 'Selecionar Todos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        92635DA46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769FF00FFFF00FFFF00FFFF00FF92635DFCF3DEFFEED5FFEED5FFEED5FF
        EED5FEEBD1FEEBD1FEEBD1FEEBD1F7EDD0A46769FF00FFFF00FFFF00FFFF00FF
        92635DF7EAD8FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82F2E2
        C7A46769FF00FFFF00FFFF00FFFF00FF92635DF8EFDEFAE9D5FAE7D4FAE7D3F8
        E6D1F8E6D0F8E6D0F8E6D0F8E6D0F0E2C9A46769FF00FFFF00FFFF00FFFF00FF
        92635DEAE2D4FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82E1D3
        BAA46769FF00FFFF00FFFF00FFFF00FF987468AA9F95A69A92A59991A5998EA4
        978BA39689A19587A19384A19183A49381986B65FF00FFFF00FF8C38168C3816
        8C38168C38168C38168C38168C38168C38168C38168C38168C38168C38168C38
        168C38168C38168C38168C3816FF00FFA77568E0E9EAE17545E17545E17545E1
        7545E17545E17545E17545E17545D7D8CAA46769FF00FF8B35128C38158C3816
        8C38168C38168C38168C38168C38168C38168C38168C38168C38168C38168C38
        168C38168C38168C3816FF00FFFF00FFB17E6BD7B09CD1AF9ED1AF9ECEAA97CC
        A995CCA793CBA591CAA590CAA38BD4A78CA46769FF00FFFF00FFFF00FFFF00FF
        BB846EFFFFFFFFE3C1FFE2C0FFE2BFFFE2BFFFE2BFFFE2BFFFE2BFFFE2BFFFFC
        EFA46769FF00FFFF00FFFF00FFFF00FFC58C70FFFFFFFEBD82FEBD82FEBD82FE
        BD82FEBD82FEBD82FEBD82FEBD82FBF6E9A46769FF00FFFF00FFFF00FFFF00FF
        CB9173FFFFFFFEFFFFFEFFFFFEFEFEFEFBFAFBFAF7FBF8F6FAF7F3F8F4F0FCFA
        F0A46769FF00FFFF00FFFF00FFFF00FFD49876FFFFFFFEBD82FEBD82FEBD82FE
        BD82FEBD82FEBD82FEBD82FEBD82FFFCF4A46769FF00FFFF00FFFF00FFFF00FF
        D49876FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFAFFFF
        FFA46769FF00FFFF00FFFF00FFFF00FFD49876CF8E68CF8E68CF8E68CF8E68CF
        8E68CF8E68CF8E68CF8E68CF8E68CF8E68A46769FF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnMarcarClick
      ExplicitLeft = 4
      ExplicitTop = 3
      ExplicitHeight = 22
    end
  end
  object grpOpcoes: TGroupBox [5]
    Left = 7
    Top = 49
    Width = 414
    Height = 106
    Caption = ' Op'#231#245'es'
    TabOrder = 2
    object lstOpcoes: TCheckListBox
      Left = 2
      Top = 16
      Width = 410
      Height = 88
      OnClickCheck = lstOpcoesClickCheck
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ItemHeight = 14
      Items.Strings = (
        'Inserir'
        'Editar'
        'Excluir')
      ParentFont = False
      TabOrder = 0
    end
  end
  object dbeCadOpe: TDBEdit [6]
    Left = 98
    Top = 21
    Width = 316
    Height = 22
    Color = 16768952
    DataField = 'OPE_NOMOPE'
    DataSource = dtsGenOpe
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object dbeLogOpe: TEditFocus [7]
    Left = 7
    Top = 21
    Width = 88
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = 'dbeLogOpe'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 189
    Width = 431
    ExplicitTop = 189
    ExplicitWidth = 431
    inherited pnlNomeForm: TPanel
      Left = 260
      ExplicitLeft = 260
    end
    inherited pnlInfo: TPanel
      Width = 260
      ExplicitWidth = 260
    end
  end
  object dtsGenOpe: TDataSource
    Left = 248
    Top = 64
  end
end
