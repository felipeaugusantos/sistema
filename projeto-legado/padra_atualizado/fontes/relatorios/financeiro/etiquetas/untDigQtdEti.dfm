inherited frmDigQtdEti: TfrmDigQtdEti
  Left = 299
  Top = 215
  Width = 465
  Height = 398
  BorderIcons = [biSystemMenu]
  Caption = 'Quantidade de Etiquetas'
  Position = poMainFormCenter
  ExplicitWidth = 465
  ExplicitHeight = 398
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 353
    Width = 459
    TabOrder = 5
    ExplicitTop = 353
    ExplicitWidth = 459
    DesignSize = (
      459
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 455
      ExplicitTop = 2
      ExplicitWidth = 455
    end
    inherited btnSair: TBitBtnLocked
      Left = 10
      Top = 0
      ExplicitLeft = 10
      ExplicitTop = 0
    end
  end
  inherited pgcDados: TPageControl
    Top = 357
    Width = 459
    Height = 0
    TabOrder = 3
    Visible = False
    ExplicitTop = 357
    ExplicitWidth = 459
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 451
      ExplicitHeight = 428
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 33
    Width = 459
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    ExplicitTop = 0
    object Label1: TLabel
      Left = 86
      Top = 20
      Width = 120
      Height = 14
      Caption = 'Quantidade de Etiquetas:'
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 213
      Top = 16
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 4
      TabOrder = 0
      Text = '0001'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttInteiro
    end
  end
  object pnlCodBar: TPanel [4]
    Left = 0
    Top = 90
    Width = 459
    Height = 267
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lblMultiSelect: TLabel
      Left = 0
      Top = 225
      Width = 255
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 'Utilize CTRL para selecionar mais de uma embalagem'
    end
    object Panel1: TPanel
      Left = 0
      Top = 239
      Width = 459
      Height = 28
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        459
        28)
      object btnCancela: TBitBtnLocked
        Left = 378
        Top = 1
        Width = 77
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Sair'
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B0000000100000001000000520000006B
          0000006B0800106B0800008C080000940800007B100000731800087B180008A5
          1800089C21001094290010A529001084310010A5310018A5310010A539001884
          4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
          4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
          5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
          AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
          BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
          CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
          D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
          DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
          F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
          FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
          FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
          5959595959595959595932514E32323232325959595959595959325266655F5F
          5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
          1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
          21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
          44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
          372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
          4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
          6A4A231B59595959595959592626262626262359595959595959}
        ModalResult = 2
        TabOrder = 1
        OnClick = btnSairClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 4
        Top = 1
        Width = 100
        Height = 22
        Caption = '[F10] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    object cxgIteBar: TcxGrid
      Left = 0
      Top = 20
      Width = 459
      Height = 205
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgIteBarView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Visible = fvNever
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GroupByBox = False
        object cxgIteBarBAR_CODBAR: TcxGridDBColumn
          Caption = 'C'#243'digo de Barras'
          DataBinding.FieldName = 'BAR_CODBAR'
          Width = 120
        end
        object cxgIteBarBAR_DESCRI: TcxGridDBColumn
          Caption = 'Des. Embalagem'
          DataBinding.FieldName = 'BAR_DESCRI'
          Width = 155
        end
        object cxgIteBarBAR_EMBALA: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'BAR_EMBALA'
          HeaderAlignmentHorz = taRightJustify
          Width = 70
        end
        object cxgIteBarBAR_PRINCI: TcxGridDBColumn
          Caption = 'Principal'
          DataBinding.FieldName = 'BAR_PRINCI'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 55
        end
        object cxgIteBarBAR_COMPRA: TcxGridDBColumn
          Caption = 'Compra'
          DataBinding.FieldName = 'BAR_COMPRA'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 55
        end
      end
      object cxgIteBarLevel1: TcxGridLevel
        GridView = cxgIteBarView
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 459
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Selecione o C'#243'digo de Barras para impress'#227'o:'
      ParentColor = True
      TabOrder = 2
    end
  end
  object pnlArmazem: TPanel [5]
    Left = 0
    Top = 0
    Width = 459
    Height = 33
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitLeft = -8
    ExplicitTop = -19
    object Label2: TLabel
      Left = 13
      Top = 10
      Width = 49
      Height = 14
      Caption = 'Armaz'#233'm:'
    end
    object cbxArmazem: TComboBoxFocus
      Left = 71
      Top = 6
      Width = 210
      Height = 22
      Style = csDropDownList
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 353
    Width = 459
    TabOrder = 4
    ExplicitTop = 353
    ExplicitWidth = 459
    inherited pnlNomeForm: TPanel
      Left = 315
      Width = 144
      ExplicitLeft = 315
      ExplicitWidth = 144
    end
    inherited pnlInfo: TPanel
      Width = 315
      ExplicitWidth = 315
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 136
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 104
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 0
  end
end
