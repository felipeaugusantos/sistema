inherited frmCadCotEmail: TfrmCadCotEmail
  Left = 281
  Top = 322
  Width = 518
  Height = 560
  Caption = 'Exporta'#231#227'o de Cota'#231#227'o'
  ExplicitWidth = 518
  ExplicitHeight = 560
  PixelsPerInch = 96
  TextHeight = 14
  object lblFornecedor: TLabel [0]
    Left = 8
    Top = 8
    Width = 369
    Height = 16
    AutoSize = False
    Caption = 'FORNEDOR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 489
    Width = 512
    Height = 26
    TabOrder = 7
    ExplicitTop = 489
    ExplicitWidth = 512
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 354
      Height = 22
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 354
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 433
      Top = 2
      Align = alRight
      ExplicitLeft = 433
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 22
      Align = alLeft
      Caption = '&Confirma'
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 515
    Width = 512
    TabOrder = 6
    ExplicitTop = 515
    ExplicitWidth = 512
    inherited pnlNomeForm: TPanel
      Left = 341
      ExplicitLeft = 341
    end
    inherited pnlInfo: TPanel
      Width = 341
      ExplicitWidth = 341
    end
  end
  object rdgGerArq: TRadioGroup [3]
    Left = 8
    Top = 32
    Width = 161
    Height = 49
    Caption = 'Gerar arquivo em'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Excel'
      'PDF')
    TabOrder = 0
    OnClick = rdgGerArqClick
  end
  object grbInfEma: TGroupBox [4]
    Left = 8
    Top = 375
    Width = 489
    Height = 89
    Caption = 'Informa'#231#245'es para email'
    TabOrder = 5
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'E-mail:'
    end
    object Label2: TLabel
      Left = 8
      Top = 54
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Contato:'
    end
    object edtEmail: TEditFocus
      Tag = 99
      Left = 51
      Top = 24
      Width = 422
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 80
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtContato: TEditFocus
      Tag = 99
      Left = 51
      Top = 46
      Width = 422
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object chkEnvEma: TCheckBox [5]
    Left = 175
    Top = 27
    Width = 97
    Height = 17
    Caption = 'Enviar por email'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = chkEnvEmaClick
  end
  object chkExbAplicProd: TCheckBox [6]
    Left = 175
    Top = 44
    Width = 170
    Height = 17
    Caption = 'Exibir Aplica'#231#227'o do produto'
    Checked = True
    State = cbChecked
    TabOrder = 2
    WordWrap = True
  end
  object rdgOrdenacao: TRadioGroup [7]
    Left = 8
    Top = 97
    Width = 489
    Height = 49
    Caption = 'Ordena'#231#227'o:'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'C'#243'digo do Item'
      'Descri'#231#227'o do Item'
      'Marca + Descri'#231#227'o do Item'
      'C'#243'digo de F'#225'brica')
    TabOrder = 4
  end
  object chkMsgLivre: TCheckBox [8]
    Left = 175
    Top = 61
    Width = 155
    Height = 17
    Caption = 'Exibir Mensagem Livre'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object rdgOpcIte: TRadioGroup [9]
    Left = 8
    Top = 224
    Width = 489
    Height = 57
    Caption = 'Exportar:'
    ItemIndex = 0
    Items.Strings = (
      'Apenas os itens vinculados ao fornecedor'
      'Todos os itens')
    TabOrder = 8
  end
  object rdgTipoCod: TRadioGroup [10]
    Left = 8
    Top = 154
    Width = 161
    Height = 57
    Caption = 'Tipo da unidade'
    ItemIndex = 1
    Items.Strings = (
      'Compra'
      'Venda')
    TabOrder = 9
  end
  object rdgFormato: TRadioGroup [11]
    Left = 346
    Top = 32
    Width = 151
    Height = 49
    Caption = 'Formato'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Retrato'
      'Paisagem')
    TabOrder = 11
  end
  object chkExbMarca: TCheckBox [12]
    Left = 175
    Top = 78
    Width = 155
    Height = 17
    Caption = 'Exibir Marca'
    Checked = True
    State = cbChecked
    TabOrder = 12
    OnClick = chkExbMarcaClick
  end
  object grpExpColunas: TGroupBox [13]
    Left = 8
    Top = 287
    Width = 489
    Height = 78
    Caption = 'Exportar Colunas'
    Padding.Left = 5
    Padding.Top = 3
    TabOrder = 13
    object chkReferencia: TCheckBox
      Left = 7
      Top = 53
      Width = 480
      Height = 17
      Align = alTop
      Caption = 'Refer'#234'ncia'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkSemelhantes: TCheckBox
      Left = 7
      Top = 19
      Width = 480
      Height = 17
      Align = alTop
      Caption = 'Semelhantes'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkCna: TCheckBox
      Left = 7
      Top = 36
      Width = 480
      Height = 17
      Align = alTop
      Caption = 'C'#243'digo CNA'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object chkExportarSemPreco: TCheckBox [14]
    Left = 175
    Top = 161
    Width = 130
    Height = 17
    Caption = 'Exportar sem pre'#231'o'
    TabOrder = 10
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 216
  end
end
