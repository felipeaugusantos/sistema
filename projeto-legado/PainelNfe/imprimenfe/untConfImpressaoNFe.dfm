object frmConfImpressaoNFe: TfrmConfImpressaoNFe
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#227'o da DANFE'
  ClientHeight = 637
  ClientWidth = 998
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 716
    Height = 601
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object GridDB: TcxGridDBTableView
      OnKeyDown = GridDBKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsQuery
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      NewItemRow.InfoText = 'Clique aqui para inserir um novo registro'
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      OptionsView.IndicatorWidth = 20
      object GridDBNFE_CODEMP: TcxGridDBColumn
        Caption = 'C'#243'd.Empresa'
        DataBinding.FieldName = 'NFE_CODEMP'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 70
      end
      object GridDBNFE_VERSAO: TcxGridDBColumn
        Caption = 'Vers'#227'o NFe'
        DataBinding.FieldName = 'NFE_VERSAO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Width = 63
      end
      object GridDBNFE_MODELO: TcxGridDBColumn
        Caption = 'Modelo'
        DataBinding.FieldName = 'NFE_MODELO'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.CharCase = ecUpperCase
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'NFE'
          'NFCE'
          'SAT')
        Options.Editing = False
        Options.Focusing = False
        Width = 68
      end
      object GridDBNFE_ORIENT: TcxGridDBColumn
        Caption = 'Orienta'#231#227'o da p'#225'gina'
        DataBinding.FieldName = 'NFE_ORIENT'
        PropertiesClassName = 'TcxRadioGroupProperties'
        Properties.Columns = 2
        Properties.Items = <
          item
            Caption = 'Retrato'
            Value = 1
          end
          item
            Caption = 'Paisagem'
            Value = 2
          end>
        Width = 207
      end
      object GridDBNFE_POSREC: TcxGridDBColumn
        Caption = 'Posi'#231#227'o Recibo (Canhoto)'
        DataBinding.FieldName = 'NFE_POSREC'
        PropertiesClassName = 'TcxRadioGroupProperties'
        Properties.Columns = 2
        Properties.Items = <
          item
            Caption = 'Cabe'#231'alho'
            Value = 0
          end
          item
            Caption = 'Rodap'#233
            Value = 1
          end>
        Width = 251
      end
    end
    object GridLevel1: TcxGridLevel
      GridView = GridDB
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 618
    Width = 998
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 
      'Selecione a empresa desejada e tecle F12 para imprimir uma DANFE' +
      ' NFe de teste.'
  end
  object Panel1: TPanel
    Left = 716
    Top = 0
    Width = 282
    Height = 601
    Align = alRight
    TabOrder = 2
    object Panel2: TPanel
      Left = 1
      Top = 285
      Width = 280
      Height = 315
      Align = alBottom
      TabOrder = 0
      object btnCarregarImagem: TcxButton
        Left = 1
        Top = 2
        Width = 138
        Height = 31
        Caption = 'Carregar imagem'
        TabOrder = 0
        TabStop = False
        WordWrap = True
        OnClick = btnCarregarImagemClick
      end
      object btnApagarImagem: TcxButton
        Left = 139
        Top = 2
        Width = 140
        Height = 31
        Caption = 'Apagar imagem'
        TabOrder = 1
        TabStop = False
        WordWrap = True
        OnClick = btnApagarImagemClick
      end
      object btnImprimirDanfeTeste: TcxButton
        Left = 1
        Top = 278
        Width = 278
        Height = 33
        Caption = '[F12] - Imprimir Danfe NFe Teste'
        TabOrder = 11
        TabStop = False
        WordWrap = True
        OnClick = btnImprimirDanfeTesteClick
      end
      object btnLayout: TcxButton
        Left = 1
        Top = 212
        Width = 278
        Height = 33
        Caption = '[F10] - Editar Layout NFCe / SAT / RG'
        TabOrder = 9
        TabStop = False
        WordWrap = True
        OnClick = btnLayoutClick
      end
      object btnResetLayout: TcxButton
        Left = 1
        Top = 245
        Width = 278
        Height = 33
        Caption = '[F11] - Restaurar Layout Padr'#227'o NFCe / SAT / RG'
        TabOrder = 10
        TabStop = False
        WordWrap = True
        OnClick = btnResetLayoutClick
      end
      object btnImportarLayoutDANFeNFe: TcxButton
        Left = 1
        Top = 80
        Width = 138
        Height = 33
        Caption = 'Importar layout DANFe NFe'
        TabOrder = 3
        TabStop = False
        WordWrap = True
        OnClick = btnImportarLayoutDANFeNFeClick
      end
      object btnExportarLayoutDANFeNFe: TcxButton
        Left = 139
        Top = 80
        Width = 140
        Height = 33
        Caption = 'Exportar layout DANFe NFe'
        TabOrder = 4
        TabStop = False
        WordWrap = True
        OnClick = btnExportarLayoutDANFeNFeClick
      end
      object rdgLayNFe: TRadioGroup
        Left = 1
        Top = 37
        Width = 278
        Height = 43
        Caption = ' Orienta'#231#227'o do layout NFe / NFCe / SAT / RG'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Retrato'
          'Paisagem')
        TabOrder = 2
      end
      object btnImportarLayoutDANFeNFCeSAT: TcxButton
        Left = 1
        Top = 179
        Width = 138
        Height = 33
        Caption = 'Importar layout NFe / NFSe / NFCe / SAT / RG'
        TabOrder = 7
        TabStop = False
        WordWrap = True
        OnClick = btnImportarLayoutDANFeNFCeSATClick
      end
      object btnExportarLayoutDANFeNFCeSAT: TcxButton
        Left = 139
        Top = 179
        Width = 140
        Height = 33
        Caption = 'Exportar layout DANFe NFCe / SAT / RG'
        TabOrder = 8
        TabStop = False
        WordWrap = True
        OnClick = btnExportarLayoutDANFeNFCeSATClick
      end
      object btnImportarLayoutDANFeNFeSimplificado: TcxButton
        Left = 1
        Top = 113
        Width = 138
        Height = 33
        Caption = 'Importar layout DANFe NFe Simplificado'
        TabOrder = 5
        TabStop = False
        WordWrap = True
        OnClick = btnImportarLayoutDANFeNFeSimplificadoClick
      end
      object btnExportarLayoutDANFeNFeSimplificado: TcxButton
        Left = 139
        Top = 113
        Width = 140
        Height = 33
        Caption = 'Exportar layout DANFe NFe Simplificado'
        TabOrder = 6
        TabStop = False
        WordWrap = True
        OnClick = btnExportarLayoutDANFeNFeSimplificadoClick
      end
      object btnImportarLayoutDANFeNFeUnificado: TcxButton
        Left = 1
        Top = 146
        Width = 138
        Height = 33
        Caption = 'Importar layout DANFe NFe Unificado'
        TabOrder = 12
        TabStop = False
        WordWrap = True
        OnClick = btnImportarLayoutDANFeNFeUnificadoClick
      end
      object btnExportarLayoutDANFeNFeUnificado: TcxButton
        Left = 139
        Top = 146
        Width = 140
        Height = 33
        Caption = 'Exportar layout DANFe NFe Unificado'
        TabOrder = 13
        TabStop = False
        WordWrap = True
        OnClick = btnExportarLayoutDANFeNFeUnificadoClick
      end
    end
    object pgcImagem: TPageControl
      Left = 1
      Top = 1
      Width = 280
      Height = 233
      ActivePage = tbsLogo
      Align = alTop
      TabOrder = 1
      object tbsLogo: TTabSheet
        Caption = 'Logo da Empresa'
        object lblLogoSize: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 192
          Width = 266
          Height = 13
          Align = alBottom
          Caption = '0 KB'
          OnClick = lblLogoSizeClick
          ExplicitWidth = 21
        end
        object imgLogo: TcxImage
          Left = 0
          Top = 0
          TabStop = False
          Align = alClient
          TabOrder = 0
          Transparent = True
          OnClick = imgLogoClick
          Height = 189
          Width = 272
        end
      end
      object tbsMarcaDagua: TTabSheet
        Caption = 'Marca d'#39#225'gua'
        ImageIndex = 1
        object lblMarcaDaguaSize: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 192
          Width = 266
          Height = 13
          Align = alBottom
          Caption = '0 KB'
          OnClick = lblMarcaDaguaSizeClick
          ExplicitWidth = 21
        end
        object imgMarcaDagua: TcxImage
          Left = 0
          Top = 0
          TabStop = False
          Align = alClient
          TabOrder = 0
          Transparent = True
          OnClick = imgMarcaDaguaClick
          Height = 189
          Width = 272
        end
      end
      object tbsBrasao: TTabSheet
        Caption = 'Bras'#227'o Prefeitura'
        ImageIndex = 2
        object lblLogoBrasao: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 192
          Width = 266
          Height = 13
          Align = alBottom
          Caption = '0 KB'
          OnClick = lblLogoBrasaoClick
          ExplicitWidth = 21
        end
        object imgBrasaoPrefeitura: TcxImage
          Left = 0
          Top = 0
          TabStop = False
          Align = alClient
          TabOrder = 0
          Transparent = True
          Height = 189
          Width = 272
        end
      end
    end
    object pnlNFSePortalNacional: TPanel
      Left = 1
      Top = 200
      Width = 280
      Height = 85
      Align = alBottom
      TabOrder = 2
      object lblPrefeitura: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 48
        Height = 13
        Caption = 'Prefeitura'
      end
      object lblSecretaria: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 43
        Width = 49
        Height = 13
        Caption = 'Secretaria'
      end
      object dbePrefeitura: TDBEditFocus
        Tag = 99
        Left = 5
        Top = 20
        Width = 268
        Height = 21
        DataField = 'NFE_NOMPRE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 70
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSecretaria: TDBEditFocus
        Tag = 99
        Left = 5
        Top = 59
        Width = 268
        Height = 21
        DataField = 'NFE_NOMSEC'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 70
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pgbProgresso: TProgressBar
    Left = 0
    Top = 601
    Width = 998
    Height = 17
    Align = alBottom
    TabOrder = 3
  end
  object odXML: TOpenDialog
    Filter = 'xml|*.xml'
    Title = 'Selecione um XML de uma NFe'
    Left = 129
    Top = 165
  end
  object dsQuery: TDataSource
    OnDataChange = dsQueryDataChange
    Left = 60
    Top = 100
  end
  object odImg: TOpenDialog
    Filter = 'Bitmap|*.bmp'
    Title = 'Selecione uma imagem'
    Left = 185
    Top = 165
  end
  object PrintDialog1: TPrintDialog
    Left = 62
    Top = 167
  end
  object odImpDANFe: TOpenDialog
    Filter = 'DANFe|*.fr3'
    Title = 'Selecione um arquivo DANFe fr3'
    Left = 257
    Top = 165
  end
  object sdExpDANFe: TSaveDialog
    DefaultExt = '.fr3'
    Filter = 'DANFe|*.fr3'
    Left = 256
    Top = 216
  end
  object tmrCarregarLayouts: TTimer
    OnTimer = tmrCarregarLayoutsTimer
    Left = 296
    Top = 312
  end
end
