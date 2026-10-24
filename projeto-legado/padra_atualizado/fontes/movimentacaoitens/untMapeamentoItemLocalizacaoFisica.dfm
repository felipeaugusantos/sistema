inherited frmMapeamentoItemLocalizacaoFisica: TfrmMapeamentoItemLocalizacaoFisica
  Width = 984
  Height = 450
  Caption = 'Mapeamento Item por Localiza'#231#227'o F'#237'sica'
  ExplicitWidth = 984
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 379
    Width = 978
    TabOrder = 1
    ExplicitTop = 379
    ExplicitWidth = 978
    inherited FlwBotoes: TFlowPanel
      Width = 897
      ExplicitWidth = 897
      inherited btnConfirma: TBitBtnLocked
        Width = 142
        Align = alLeft
        Caption = 'Confirma [F10]'
        ModalResult = 0
        ExplicitWidth = 142
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 899
      Top = 2
      Align = alRight
      ExplicitLeft = 899
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 978
    TabOrder = 3
    ExplicitTop = 405
    ExplicitWidth = 978
    inherited pnlNomeForm: TPanel
      Left = 740
      Width = 238
      ExplicitLeft = 740
      ExplicitWidth = 238
    end
    inherited pnlInfo: TPanel
      Width = 740
      ExplicitWidth = 740
    end
  end
  object pnlItem: TPanel [2]
    Left = 0
    Top = 0
    Width = 978
    Height = 129
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      978
      129)
    object Label11: TLabel
      Left = 9
      Top = 81
      Width = 89
      Height = 14
      Caption = 'Localiza'#231#227'o F'#237'sica'
    end
    object Label1: TLabel
      Left = 586
      Top = 81
      Width = 104
      Height = 14
      Caption = 'Qtd. Ponto Reposi'#231#227'o'
    end
    object Label2: TLabel
      Left = 707
      Top = 81
      Width = 59
      Height = 14
      Caption = 'Qtd. M'#225'xima'
    end
    object lblCodOpe: TLabel
      Left = 9
      Top = 40
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador'
    end
    object Label7: TLabel
      Left = 9
      Top = 14
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label10: TLabel
      Left = 734
      Top = 13
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Refer'#234'ncia:'
      ExplicitLeft = 555
    end
    object Bevel1: TBevel
      Left = 0
      Top = 37
      Width = 978
      Height = 2
    end
    object edtLocFis: TEditFocus
      Tag = 99
      Left = 9
      Top = 98
      Width = 135
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 1
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPontoReposicao: TEditFocus
      Tag = 99
      Left = 586
      Top = 98
      Width = 115
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtQtdMaxima: TEditFocus
      Tag = 99
      Left = 707
      Top = 98
      Width = 73
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 786
      Top = 98
      Width = 90
      Height = 22
      Anchors = [akTop, akRight]
      Caption = '&Confirma'
      Enabled = False
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
      TabOrder = 4
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 879
      Top = 98
      Width = 90
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'C&ancelar'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 5
      OnClick = btnCancelaItemClick
    end
    object edtDesLoc: TEditFocus
      Left = 150
      Top = 98
      Width = 430
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 73
      Top = 53
      Width = 430
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 9
      Top = 53
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 0
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 35
      Top = 10
      Width = 50
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 8
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 86
      Top = 10
      Width = 645
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 791
      Top = 10
      Width = 178
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgLocIte: TcxGridCitel [3]
    Left = 0
    Top = 129
    Width = 978
    Height = 250
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgLocIteTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgLocIteTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgLocIteTableViewCODLOC: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOC_CODLOC'
        Width = 151
      end
      object cxgLocIteTableViewDESLOC: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Localiza'#231#227'o'
        DataBinding.FieldName = 'LOC_DESCRI'
        Width = 430
      end
      object cxgLocIteTableViewQTDREP: TcxGridDBColumn
        Caption = 'Qtd. Ponto Reposi'#231#227'o'
        DataBinding.FieldName = 'LCI_QTDREP'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 133
      end
      object cxgLocIteTableViewQTDMAX: TcxGridDBColumn
        Caption = 'Qtd. M'#225'xima'
        DataBinding.FieldName = 'LCI_QTDMAX'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 133
      end
      object cxgLocIteTableViewTIPLOC: TcxGridDBColumn
        Caption = 'Tipo de Localiza'#231#227'o'
        DataBinding.FieldName = 'TIPO_LOCALIZACAO'
        Width = 106
      end
    end
    object cxgLocIteLevel: TcxGridLevel
      GridView = cxgLocIteTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 680
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 624
    Top = 140
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 712
    Top = 72
  end
end
