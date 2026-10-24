inherited frmCadLocAdicionais: TfrmCadLocAdicionais
  Width = 650
  Height = 452
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Cadastro de Localiza'#231#245'es F'#237'sicas Adicionais'
  Position = poDefault
  ExplicitWidth = 650
  ExplicitHeight = 452
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 408
    Width = 650
    TabOrder = 2
    ExplicitTop = 408
    ExplicitWidth = 650
    inherited btnSair: TBitBtnLocked
      Left = 567
      Visible = False
      ExplicitLeft = 567
    end
    object btnExcluir: TBitBtnLocked
      Left = 7
      Top = 3
      Width = 125
      Height = 22
      Caption = '&Exclui localiza'#231#227'o'
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
      TabOrder = 1
      OnClick = btnExcluirClick
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 23
    Width = 650
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label5: TLabel
      Left = 12
      Top = 21
      Width = 120
      Height = 14
      Caption = 'Nova Localiza'#231#227'o Fisica:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpLocFisAdi: TShape
      Left = 132
      Top = 15
      Width = 6
      Height = 21
      Visible = False
    end
    object edtLocFis: TEditFocus
      Tag = 99
      Left = 138
      Top = 15
      Width = 112
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
      MaxLength = 30
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttAlfanumerico
    end
    object edtDescri: TEditFocus
      Left = 251
      Top = 15
      Width = 310
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgLocFis: TcxGrid [3]
    Left = 0
    Top = 80
    Width = 650
    Height = 328
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvLocFis: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxvLocFisLOCFIS: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'LOC_LOCFIS'
        Width = 123
      end
      object cxvLocFisDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o da Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOC_DESCRI'
        Width = 480
      end
    end
    object cxgLocFisLevel1: TcxGridLevel
      GridView = cxvLocFis
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 0
    Width = 650
    Height = 23
    Align = alTop
    Caption = 'Localiza'#231#245'es F'#237'sicas Adicionais'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  inherited pnlStatus: TPanel
    Top = 436
    Width = 650
    TabOrder = 3
    ExplicitTop = 436
    ExplicitWidth = 650
    inherited pnlNomeForm: TPanel
      Left = 479
      ExplicitLeft = 479
    end
    inherited pnlInfo: TPanel
      Width = 479
      ExplicitWidth = 479
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 120
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 248
    Top = 168
  end
end
