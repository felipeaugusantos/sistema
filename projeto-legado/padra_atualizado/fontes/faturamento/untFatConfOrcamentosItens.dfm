inherited frmFatConfOrcamentosItens: TfrmFatConfOrcamentosItens
  Left = 260
  Top = 180
  Width = 656
  Height = 436
  Caption = 'Confer'#234'ncia de Produtos: '
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 656
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 363
    Width = 650
    TabOrder = 1
    ExplicitTop = 363
    ExplicitWidth = 721
    DesignSize = (
      650
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 646
      TabOrder = 5
      ExplicitWidth = 717
    end
    inherited btnSair: TBitBtnLocked
      Left = 567
      TabOrder = 4
      ExplicitLeft = 638
    end
    object btnQuantidade: TBitBtnLocked
      Left = 103
      Top = 3
      Width = 100
      Height = 22
      Caption = '[F6] Quantidade'
      TabOrder = 1
      OnClick = btnQuantidadeClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 100
      Height = 22
      Caption = '[F10] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnExpAut: TBitBtnLocked
      Left = 203
      Top = 3
      Width = 171
      Height = 22
      Caption = '[F7] Expedi'#231#227'o "Autom'#225'tica"'
      TabOrder = 2
      OnClick = btnExpAutClick
    end
    object btnMarcarTudo: TBitBtnLocked
      Left = 374
      Top = 3
      Width = 125
      Height = 22
      Caption = '[F8] Marcar todos'
      TabOrder = 3
      OnClick = btnMarcarTudoClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 391
    Width = 650
    TabOrder = 2
    ExplicitTop = 391
    ExplicitWidth = 721
    inherited pnlNomeForm: TPanel
      Left = 479
      ExplicitLeft = 550
    end
    inherited pnlInfo: TPanel
      Width = 479
      ExplicitWidth = 550
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 650
    Height = 363
    Align = alClient
    Color = 16770261
    TabOrder = 0
    ExplicitWidth = 721
    object dbgItens: TDBGridCitel
      Left = 1
      Top = 1
      Width = 648
      Height = 318
      Align = alClient
      DataSource = dtsItens
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgItensDrawColumnCell
      OnKeyDown = dbgItensKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DESITE'
          Title.Caption = 'Produto'
          Width = 426
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIDAD'
          Title.Caption = 'Unidade'
          Width = 50
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SALEST'
          Title.Alignment = taRightJustify
          Title.Caption = 'Estoque'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Quantidade'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'QTDLIB'
          Title.Caption = 'Expedido'
          Visible = True
        end>
    end
    object pnlRodape: TPanel
      Left = 1
      Top = 319
      Width = 648
      Height = 43
      Align = alBottom
      Color = 16770261
      TabOrder = 1
      ExplicitWidth = 719
      object lblCodBar: TLabel
        Left = 8
        Top = 22
        Width = 152
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo de Barras (Embalagem):'
      end
      object Label2: TLabel
        Left = 291
        Top = 22
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblLimparExpedido: TLabel
        Left = 1
        Top = 1
        Width = 646
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = 
          'Para limpar a quantidade conferida do produto, selecione o mesmo' +
          ' e pressione as teclas [Shift +F5]'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 479
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 161
        Top = 18
        Width = 121
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 18
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdIte: TEditFocus
        Tag = 99
        Left = 352
        Top = 18
        Width = 73
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        MaxLength = 12
        TabOrder = 1
        Text = '1,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
  object qryItens: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 464
    Top = 80
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 352
    Top = 80
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 400
    Top = 80
  end
  object dspItens: TUniDataSetProvider
    DataSet = qryItens
    Options = []
    Left = 432
    Top = 80
  end
end
