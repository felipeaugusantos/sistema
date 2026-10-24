inherited frmCtrMostraAgrupadas: TfrmCtrMostraAgrupadas
  Left = 214
  Top = 199
  Width = 709
  Height = 324
  BorderIcons = [biSystemMenu]
  Caption = 'Duplicatas Agrupadas'
  Font.Quality = fqClearType
  ParentBiDiMode = False
  Position = poMainFormCenter
  ExplicitWidth = 709
  ExplicitHeight = 324
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 253
    Width = 703
    Height = 26
    ExplicitTop = 253
    ExplicitWidth = 703
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 622
      Height = 22
      ExplicitWidth = 622
      ExplicitHeight = 22
      object btnProdutos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 127
        Height = 22
        Caption = '[ F7 ] - Produtos'
        TabOrder = 0
        OnClick = btnProdutosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 624
      Top = 2
      Align = alRight
      ExplicitLeft = 624
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 279
    Width = 703
    ExplicitTop = 279
    ExplicitWidth = 703
    inherited pnlNomeForm: TPanel
      Left = 532
      ExplicitLeft = 532
    end
    inherited pnlInfo: TPanel
      Width = 532
      ExplicitWidth = 532
    end
  end
  object dbgDuplicatas: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 703
    Height = 191
    Align = alClient
    DataSource = dtsDados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    TitleFont.Quality = fqClearType
    OnDrawColumnCell = dbgDuplicatasDrawColumnCell
    OnKeyDown = dbgDuplicatasKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CTR_DUPPAR'
        ImeName = 'CTR_NUMDUP'
        Title.Caption = 'Duplicata'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_ESPDOC'
        ImeName = 'CTR_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODEMP'
        Title.Caption = 'Emp.'
        Width = 36
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 184
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODVEL'
        Title.Caption = 'Doc.Antigo'
        Width = 69
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTR_DTACAD'
        Title.Alignment = taRightJustify
        Title.Caption = 'Data Cadastro'
        Width = 74
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTR_DTAVEN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vencimento'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTR_VALFOR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Visible = True
      end>
  end
  object pnlStatPromoc: TPanel [3]
    Left = 0
    Top = 191
    Width = 703
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    ExplicitLeft = -2
    ExplicitTop = 173
    DesignSize = (
      703
      18)
    object Shape1: TShape
      Left = 532
      Top = 5
      Width = 17
      Height = 10
      Anchors = [akTop, akRight]
      Brush.Color = clTeal
    end
    object Label17: TLabel
      Left = 552
      Top = 3
      Width = 146
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Duplicatas com Promo'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      ParentFont = False
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 235
    Width = 703
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 4
    object Label3: TLabel
      Left = 0
      Top = 0
      Width = 703
      Height = 18
      Align = alClient
      Alignment = taCenter
      Caption = 
        'Para agrupamentos parcelados ser'#225' exibido todas as duplicatas in' +
        'dependente da parcela.'
      Color = clActiveCaption
      ParentColor = False
      ExplicitWidth = 435
      ExplicitHeight = 14
    end
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 209
    Width = 703
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitTop = -8
    object lblValorTotal: TLabel
      Left = 557
      Top = 5
      Width = 53
      Height = 14
      Caption = 'Valor Total:'
    end
    object edtValorTotal: TEditFocus
      Left = 614
      Top = 1
      Width = 83
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object qryDados: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = True
    Options.SetFieldsReadOnly = False
    Constraints = <>
    Left = 296
    Top = 16
  end
  object dtsDados: TDataSource
    DataSet = qryDados
    Left = 328
    Top = 16
  end
end
