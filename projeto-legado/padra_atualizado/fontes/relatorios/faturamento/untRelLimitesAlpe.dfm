inherited frmRelLimitesAlpe: TfrmRelLimitesAlpe
  Width = 727
  Height = 387
  Caption = 'Relat'#243'rio - Limite de Cr'#233'dito Alpe'
  OnDestroy = FormDestroy
  ExplicitWidth = 727
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 14
  object lblCliente: TLabel [0]
    Left = 7
    Top = 9
    Width = 35
    Height = 14
    Alignment = taRightJustify
    Caption = 'Cliente:'
  end
  object LabelCgcCpf1: TLabel [1]
    Left = 452
    Top = 9
    Width = 28
    Height = 14
    Alignment = taRightJustify
    Caption = 'CNPJ:'
  end
  inherited pnlBotoes: TPanel
    Top = 316
    Width = 721
    TabOrder = 6
    ExplicitTop = 316
    ExplicitWidth = 721
    inherited FlwBotoes: TFlowPanel
      Width = 717
      ExplicitWidth = 717
      inherited btnConfirma: TBitBtnLocked
        Caption = '&Imprmir'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF00000000000000000000000000000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF000000000000000000000000000000002626264A8484
          84FF848484FF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB8824DFFB882
          4DFFFFFFFFFF848484FF848484FF848484FF848484FF2626264A848484FF8484
          84FF848484FF848484FF848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF848484FF0000000000000000848484FF848484FF8484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000848484FF848484FF848484FF777777E68484
          84FF848484FF00000000B8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFF00000000848484FF848484FF777777E6262626498484
          84FF848484FF00000000B8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFF00000000848484FF848484FF26262649000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000000000
          00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        NumGlyphs = 1
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 638
      Caption = '&Cancelar'
      ExplicitLeft = 638
    end
  end
  inherited pnlStatus: TPanel
    Top = 342
    Width = 721
    TabOrder = 7
    ExplicitTop = 342
    ExplicitWidth = 721
    inherited pnlNomeForm: TPanel
      Left = 550
      ExplicitLeft = 550
    end
    inherited pnlInfo: TPanel
      Width = 550
      ExplicitWidth = 550
    end
  end
  object edtCodCli: TEditFocus [4]
    Tag = 99
    Left = 45
    Top = 6
    Width = 65
    Height = 22
    Hint = 'Pressione INSERT para inserir um novo cliente'
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 8
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyPress = edtCodCliKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
  object edtNomCli: TEditFocus [5]
    Left = 111
    Top = 6
    Width = 330
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 1
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object gpbDestino: TGroupBox [6]
    Left = 7
    Top = 264
    Width = 219
    Height = 45
    Caption = 'Destino'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object ColorLabel1: TColorLabel
      Left = 31
      Top = 20
      Width = 177
      Height = 14
      Caption = '(V)'#237'deo (I)mpressora (P)PDF (C)CSV'
      CorDestaque = clRed
    end
    object edtDestino: TEditFocus
      Tag = 99
      Left = 7
      Top = 16
      Width = 18
      Height = 22
      Alignment = taCenter
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 0
      Text = 'V'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
  end
  object mskCgcCli: TMaskEditC_G_C_ [7]
    Tag = 99
    Left = 484
    Top = 6
    Width = 116
    Height = 22
    CharCase = ecUpperCase
    Color = 16768952
    EditMask = '>aa\.aaa\.aaa/aaaa-99;0;'
    MaxLength = 18
    ReadOnly = True
    TabOrder = 2
    Text = ''
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
    strCgcCpf = '1'
  end
  object btnAdicionar: TBitBtnLocked [8]
    Left = 611
    Top = 6
    Width = 104
    Height = 22
    Caption = '&Adicionar'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
      609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
      D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
      9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
      95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
      8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
      A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
      A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
      E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
      B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
      ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
      E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
      BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
      27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
      EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
      C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
      C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
      8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
      CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
      D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
      FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
      CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
      68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    TabOrder = 3
    OnClick = btnAdicionarClick
  end
  object cxgClientes: TcxGridCitel [9]
    Left = 7
    Top = 34
    Width = 708
    Height = 200
    TabOrder = 5
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgClientesDBTableViewCitel1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxgClientesDBTableViewCitel1EditKeyDown
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object CLI_CODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CLI_CODCLI'
        Width = 70
      end
      object CLI_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Width = 512
      end
      object CLI_C_G_C_: TcxGridDBColumn
        Caption = 'CNPJ'
        DataBinding.FieldName = 'CLI_C_G_C_'
        Width = 102
      end
    end
    object cxgClientesLevel1: TcxGridLevel
      GridView = cxgClientesDBTableViewCitel1
    end
  end
  object BitBtnLocked1: TBitBtnLocked [10]
    Left = 7
    Top = 234
    Width = 708
    Height = 23
    Caption = 'Carregar todos os clientes Alpe'
    TabOrder = 8
    OnClick = BitBtnLocked1Click
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 65496
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 792
    Top = 32
  end
end
