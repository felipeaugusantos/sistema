inherited frmManutecaoMultiLojaPosEntrada: TfrmManutecaoMultiLojaPosEntrada
  Width = 1024
  Height = 646
  Caption = 'Manuten'#231#227'o de Pedido Multi-loja Ap'#243's Entrada de Mercadoria'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 1024
  ExplicitHeight = 646
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 573
    Width = 1018
    TabOrder = 1
    ExplicitTop = 573
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 129
        Height = 23
        Caption = '&Gravar'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000040000
          00130000001E0000002000000020000000200000002100000021000000210000
          002200000022000000220000002300000021000000160000000500000012281E
          16CB37291EFF463A31FFBD8150FFBC7E4DFFB97949FFB67646FFB37141FFB06D
          3DFFAD6839FFAB6535FF42362EFF3D3026FF241A13CE00000015000000193B2C
          21FF685C54FF483C34FFE8C28BFFE7C088FFE6BD85FFE5BB81FFE4B87CFFE3B5
          79FFE2B276FFE2B273FF443931FF51433AFF34261DFF0000001E000000183E2F
          24FF6C6057FF4A3F37FFD9B27DFFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A6
          6DFFD4A56AFFD4A268FF473B33FF5B4F47FF37291EFF0000001D000000164031
          26FF6F645CFF4C4038FFFFFFFFFFF7F1EBFFF7F0EBFFF7F0EBFFF7EFEBFFF6EF
          EAFFF6EFEAFFF6EFE9FF463B34FF5D5249FF3A2C21FF0000001B000000144434
          29FF73675FFF4F443CFFFFFFFFFFF8F2EDFFF8F1EDFFF7F1EDFFF7F0EDFFF8F1
          EBFFF7F0EBFFF7F0ECFF4A4037FF5F534BFF3D2E23FF00000019000000124637
          2CFF776B63FF50453DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF4E433BFF61544CFF403126FF0000001700000010493A
          2FFF796E66FF50453DFF61564EFF60564EFF60554DFF5F544CFF5E544CFF5E53
          4BFF5D524AFF5C5249FF5B5149FF61554DFF433429FF000000150000000E4C3D
          32FF7C706AFF674E44FF654B42FF634A41FF61473FFF5F473EFF5C443CFF5B43
          3AFF594139FF584038FF573F37FF63574FFF46362DFF000000130000000D4E3F
          35FF80746DFF6B5248FFF4ECE6FFE9DACEFFE9D8CDFFE9D8CCFFE9D8CBFFE8D7
          CAFFF3EAE2FFF3E9E2FF5A4139FF645850FF483A2FFF000000110000000B5142
          36FF827770FF70564DFFF9F5F2FFF4EAE4FFF1E6DEFFEBDCD2FFE9D9CCFF4E41
          3DFF60534CFFF3EAE3FF5D453CFF655951FF4C3D32FF0000000F000000095344
          39FF857A73FF755A50FFFAF6F3FFF5EDE7FFF4EDE6FFF4ECE6FFEFE2DAFF493D
          38FF5A4D46FFF4EBE4FF60483FFF655A52FF4F3F34FF0000000D000000075545
          3AFF887D76FF795E54FFFAF6F4FFF5EEE9FFF5EDE7FFF4EDE7FFF4ECE6FF473A
          36FF483D36FFE9D9CDFF644C43FF675A52FF514137FF0000000B000000065748
          3DFF898079FF7C6157FFFAF7F4FFFAF6F4FFFAF6F4FFFAF6F3FFFAF6F3FFFAF5
          F2FFF5EEE9FFF4ECE6FF695046FF82776FFF534439FF00000009000000034235
          2EC058493DFF7F645AFF998178FF967F75FF937A72FF8E786DFF8B7269FF866E
          64FF82695FFF7D645BFF6E544AFF56453BFF3F332BC200000005000000000000
          0002000000030000000400000004000000040000000400000005000000050000
          0005000000050000000500000006000000060000000400000001}
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 601
    Width = 1018
    TabOrder = 2
    ExplicitTop = 601
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object grpPedCom: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 57
    Align = alTop
    Caption = ' Pedido de Compra '
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 13
      Width = 54
      Height = 14
      Caption = 'Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 120
      Top = 13
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 160
      Top = 13
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 18
      Top = 27
      Width = 100
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtPdEspDoc: TEditFocus
      Left = 120
      Top = 27
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 1
      Text = 'PD'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodEmpPD: TEditFocus
      Tag = 99
      Left = 160
      Top = 27
      Width = 29
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
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpPD: TEditFocus
      Left = 190
      Top = 27
      Width = 225
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnCarregar: TBitBtnLocked
      Left = 416
      Top = 26
      Width = 75
      Height = 24
      Caption = '&Carregar'
      TabOrder = 4
      OnClick = btnCarregarClick
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 57
    Width = 1018
    Height = 516
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 0
      Top = 241
      Width = 1018
      Height = 4
      Cursor = crVSplit
      Align = alTop
      Color = clYellow
      ParentColor = False
      ExplicitTop = 208
      ExplicitWidth = 955
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 241
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel1'
      TabOrder = 0
      object cxgPcmdet: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1018
        Height = 222
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvPcmdet: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Filter.Active = True
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.DeletingConfirmation = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxvPcmdetPCD_CODITE: TcxGridDBColumn
            Caption = 'C'#243'd. Item'
            DataBinding.FieldName = 'PCD_CODITE'
            MinWidth = 64
            Options.Editing = False
          end
          object cxvPcmdetColumn2: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'PCD_DESITE'
            Options.Editing = False
            Width = 306
          end
          object cxvPcmdetColumn1: TcxGridDBColumn
            Caption = 'Qtd. Pedido Original'
            DataBinding.FieldName = 'PCD_QTDITE_ORIGINAL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 110
          end
          object cxvPcmdetColumn5: TcxGridDBColumn
            Caption = 'Qtd. Baixada'
            DataBinding.FieldName = 'PCD_QTDBAI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 110
          end
          object cxvPcmdetPCD_QTDRES: TcxGridDBColumn
            Caption = 'Qtd. Restante'
            DataBinding.FieldName = 'PCD_QTDRES'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Styles.Content = cxStyle1
            Width = 110
          end
          object cxvPcmdetColumn3: TcxGridDBColumn
            Caption = 'Qtd. Item Nova'
            DataBinding.FieldName = 'PCD_QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 110
          end
          object cxvPcmdetColumn7: TcxGridDBColumn
            Caption = 'Qtd. Tranferida'
            DataBinding.FieldName = 'PCD_QTDTRA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 110
          end
          object cxgBaixarItem: TcxGridDBColumn
            Caption = 'Baixar Item?'
            DataBinding.FieldName = 'BAIXAD'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Width = 75
          end
        end
        object cxlPcmdet: TcxGridLevel
          GridView = cxvPcmdet
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 222
        Width = 1018
        Height = 19
        Align = alBottom
        Padding.Left = 5
        Padding.Top = 2
        Padding.Right = 5
        Padding.Bottom = 2
        TabOrder = 1
        object Label3: TLabel
          Left = 6
          Top = 3
          Width = 1006
          Height = 13
          Align = alClient
          Alignment = taCenter
          Caption = 
            'A Coluna "Baixar Item" far'#225' a marca'#231#227'o de baixado no item do ped' +
            'ido  e levar'#225' a necessidade de compra a zero.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 611
          ExplicitHeight = 14
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 245
      Width = 1018
      Height = 271
      Align = alClient
      TabOrder = 1
      object cxgPcddet: TcxGridCitel
        Left = 1
        Top = 1
        Width = 1016
        Height = 269
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvPcddet: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxvPcddetColumn1: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'PCD_CODEMP'
            Options.Editing = False
            Width = 373
          end
          object cxvPcddetColumn2: TcxGridDBColumn
            Caption = 'Qtd. Item'
            DataBinding.FieldName = 'PCD_QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 115
          end
          object cxvPcddetColumn3: TcxGridDBColumn
            Caption = 'Qtd. Baixada Prop.'
            DataBinding.FieldName = 'PCD_QTDBAI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            Visible = False
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 115
          end
          object cxvPcddetColumn4: TcxGridDBColumn
            Caption = 'Qtd. Transferida'
            DataBinding.FieldName = 'PCD_QTDTRA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 115
          end
        end
        object cxlPcddet: TcxGridLevel
          GridView = cxvPcddet
        end
      end
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
