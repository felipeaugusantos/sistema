inherited frmDirEspGru: TfrmDirEspGru
  Left = 215
  Top = 162
  Width = 430
  Height = 236
  HorzScrollBar.Range = 414
  VertScrollBar.Range = 200
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 430
  ExplicitHeight = 236
  PixelsPerInch = 96
  TextHeight = 14
  object lblCodGrup: TLabel [0]
    Left = 7
    Top = 6
    Width = 69
    Height = 14
    Caption = 'C'#243'digo Grupo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lblNomForm: TLabel [1]
    Left = 47
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
  object Label1: TLabel [2]
    Left = 98
    Top = 6
    Width = 97
    Height = 14
    Caption = 'Descri'#231#227'o do Grupo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 163
    Width = 424
    ExplicitTop = 163
    ExplicitWidth = 424
    inherited FlwBotoes: TFlowPanel
      Left = 114
      Width = 231
      ExplicitTop = 2
      ExplicitWidth = 420
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 345
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 342
    end
    object btnMarcar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 112
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
      TabOrder = 1
      OnClick = btnMarcarClick
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitHeight = 21
    end
  end
  object dbeDescGrup: TDBEdit [5]
    Left = 98
    Top = 21
    Width = 309
    Height = 22
    Color = 16768952
    DataField = 'GPO_DESCRI'
    DataSource = dtsGru02
    Enabled = False
    TabOrder = 2
  end
  object dbgOpcoes: TGroupBox [6]
    Left = 7
    Top = 49
    Width = 407
    Height = 106
    Caption = ' Op'#231#245'es '
    TabOrder = 3
    object lstOpcoes: TCheckListBox
      Left = 2
      Top = 16
      Width = 403
      Height = 88
      OnClickCheck = lstOpcoesClickCheck
      Align = alClient
      ItemHeight = 14
      Items.Strings = (
        'Inserir'
        'Editar'
        'Excluir')
      TabOrder = 0
    end
  end
  object dbeCodGru: TEditFocus [7]
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
    Text = 'dbeCodGru'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 191
    Width = 424
    ExplicitTop = 191
    ExplicitWidth = 424
    inherited pnlNomeForm: TPanel
      Left = 253
      ExplicitLeft = 253
    end
    inherited pnlInfo: TPanel
      Width = 253
      ExplicitWidth = 253
    end
  end
  object dtsGru02: TDataSource
    Left = 256
    Top = 80
  end
end
