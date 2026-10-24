inherited frmModalidades: TfrmModalidades
  Left = 395
  Top = 260
  Width = 591
  Height = 508
  ActiveControl = cbxModalidades
  BorderIcons = [biSystemMenu]
  Caption = 'Modalidades de Pagamento'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 591
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 313
    Width = 585
    Height = 0
    Visible = False
    ExplicitTop = 313
    ExplicitWidth = 585
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 581
    end
    inherited btnSair: TBitBtnLocked
      Left = 511
      Top = -25
      ExplicitLeft = 511
      ExplicitTop = -25
    end
  end
  object pnlGrid: TPanel [2]
    Left = 0
    Top = 0
    Width = 585
    Height = 313
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Shape2: TShape
      Left = 5
      Top = 5
      Width = 575
      Height = 303
      Align = alClient
      Brush.Color = 16770261
      Pen.Color = clWhite
      Shape = stRoundRect
      ExplicitWidth = 573
      ExplicitHeight = 298
    end
    object Label1: TLabel
      Left = 28
      Top = 13
      Width = 88
      Height = 19
      Caption = 'Modalidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 28
      Top = 75
      Width = 3
      Height = 14
    end
    object Label3: TLabel
      Left = 28
      Top = 71
      Width = 39
      Height = 19
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 27
      Top = 248
      Width = 196
      Height = 19
      Caption = '[ F5 ] - Editar Modalidades'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 27
      Top = 270
      Width = 129
      Height = 19
      Caption = '[ F10 ] - Confirma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCpf: TLabel
      Left = 28
      Top = 191
      Width = 39
      Height = 19
      Caption = 'CPF:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel6: TPanel
      Left = 254
      Top = 15
      Width = 311
      Height = 283
      BevelOuter = bvNone
      BorderWidth = 5
      Color = 16770261
      Ctl3D = True
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 3
      object dbgModalidades: TDBGridCitel
        Left = 5
        Top = 5
        Width = 301
        Height = 273
        Align = alClient
        Color = 16316664
        Ctl3D = False
        DataSource = dtsModalidades
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -16
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = [fsBold]
        OnKeyDown = dbgModalidadesKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'DESMOD'
            Title.Color = 13750737
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Title.Alignment = taRightJustify
            Title.Color = 13750737
            Width = 120
            Visible = True
          end>
      end
    end
    object cbxModalidades: TComboBoxFocus
      Left = 28
      Top = 30
      Width = 219
      Height = 26
      BevelInner = bvLowered
      BevelKind = bkFlat
      Style = csDropDownList
      Color = 16316664
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      OnExit = cbxModalidadesExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtValor: TCurrencyEditFocus
      Left = 28
      Top = 88
      Margins.Left = 6
      Margins.Top = 2
      AutoSize = False
      ParentFont = False
      Properties.DisplayFormat = '0.00;-0.00'
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.IsFontAssigned = True
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      OnExit = edtValorExit
      OnKeyPress = edtValorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Height = 26
      Width = 219
    end
    object memAviso: TMemo
      Left = 29
      Top = 119
      Width = 217
      Height = 57
      TabStop = False
      Alignment = taCenter
      BorderStyle = bsNone
      Color = 16316664
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Lines.Strings = (
        'Esta modalidade pode ser '
        'selecionada apenas uma '
        'vez.')
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Visible = False
    end
    object mskCgcCpf: TMaskEditFocus
      Left = 28
      Top = 208
      Width = 218
      Height = 24
      Ctl3D = False
      EditMask = '999.999.999-99;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = ''
      OnExit = mskCgcCpfExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object chkEndEnt: TCheckBox
      Left = 340
      Top = 294
      Width = 212
      Height = 17
      Caption = 'Imprimir endere'#231'o de entrega'
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 313
    Width = 585
    Height = 166
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 5
    Color = 16770261
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 3
    object Shape1: TShape
      Left = 5
      Top = 5
      Width = 575
      Height = 156
      Align = alClient
      Brush.Color = 16770261
      Pen.Color = clWhite
      Shape = stRoundRect
      ExplicitWidth = 573
    end
    object Panel2: TPanel
      Left = 35
      Top = 16
      Width = 249
      Height = 64
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Shape4: TShape
        Left = 0
        Top = 0
        Width = 249
        Height = 64
        Align = alClient
        Brush.Color = clGray
        Pen.Color = clWhite
        Shape = stRoundRect
      end
      object lblValCompra: TLabel
        Left = 138
        Top = 23
        Width = 102
        Height = 19
        Alignment = taRightJustify
        Caption = 'lblValCompra'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object StaticText1: TStaticText
        Left = 3
        Top = 24
        Width = 144
        Height = 22
        AutoSize = False
        Caption = 'Total Compra R$:'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object Panel3: TPanel
      Left = 310
      Top = 16
      Width = 249
      Height = 64
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Shape5: TShape
        Left = 0
        Top = 0
        Width = 249
        Height = 64
        Align = alClient
        Brush.Color = clGray
        Pen.Color = clWhite
        Shape = stRoundRect
      end
      object StaticText5: TStaticText
        Left = 3
        Top = 24
        Width = 135
        Height = 22
        AutoSize = False
        Caption = 'Valor Pago R$:'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
      object dbePago: TDBEditFocus
        Left = 149
        Top = 23
        Width = 90
        Height = 26
        TabStop = False
        AutoSize = False
        BorderStyle = bsNone
        Color = clGray
        Ctl3D = False
        DataField = 'AGG_PAGO'
        DataSource = dtsModalidades
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
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
    object Panel4: TPanel
      Left = 35
      Top = 88
      Width = 249
      Height = 64
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object Shape6: TShape
        Left = 0
        Top = 0
        Width = 249
        Height = 64
        Align = alClient
        Brush.Color = clGray
        Pen.Color = clWhite
        Shape = stRoundRect
      end
      object lblValRestante: TLabel
        Left = 131
        Top = 25
        Width = 109
        Height = 19
        Alignment = taRightJustify
        Caption = 'lblValRestante'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object StaticText2: TStaticText
        Left = 3
        Top = 26
        Width = 147
        Height = 22
        AutoSize = False
        Caption = 'Valor Restante R$:'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object Panel5: TPanel
      Left = 310
      Top = 88
      Width = 249
      Height = 64
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object Shape7: TShape
        Left = 0
        Top = 0
        Width = 249
        Height = 64
        Align = alClient
        Brush.Color = clGray
        Pen.Color = clWhite
        Shape = stRoundRect
      end
      object lblValTroco: TLabel
        Left = 155
        Top = 25
        Width = 85
        Height = 19
        Alignment = taRightJustify
        Caption = 'lblValTroco'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object StaticText3: TStaticText
        Left = 3
        Top = 26
        Width = 110
        Height = 22
        AutoSize = False
        Caption = 'Troco R$:'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 313
    Width = 585
    Height = 0
    Visible = False
    ExplicitTop = 313
    ExplicitWidth = 585
    ExplicitHeight = 0
    inherited pnlNomeForm: TPanel
      Left = 414
      Height = 0
      Visible = False
      ExplicitLeft = 414
      ExplicitHeight = 0
    end
    inherited pnlInfo: TPanel
      Width = 414
      Height = 0
      Visible = False
      ExplicitWidth = 414
      ExplicitHeight = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 456
    Top = 104
  end
  object dtsModalidades: TDataSource
    DataSet = cdsModalidades
    Left = 425
    Top = 104
  end
  object cdsModalidades: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'IDX_ECF_CODMOD'
        Fields = 'ECF_CODMOD'
      end>
    IndexName = 'IDX_ECF_CODMOD'
    Params = <>
    StoreDefs = True
    AfterPost = cdsModalidadesAfterPost
    AfterDelete = cdsModalidadesAfterDelete
    Left = 395
    Top = 104
    object cdsModalidadesVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = '#,##0.00'
    end
    object cdsModalidadesTROCO: TFloatField
      FieldName = 'TROCO'
      DisplayFormat = '#,##0.00'
    end
    object cdsModalidadesRESTANTE: TFloatField
      FieldName = 'RESTANTE'
      DisplayFormat = '#,##0.00'
    end
    object cdsModalidadesDESMOD: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESMOD'
      Size = 30
    end
    object cdsModalidadesECF_CODMOD: TStringField
      FieldName = 'ECF_CODMOD'
      Size = 2
    end
    object cdsModalidadesECF_IDENTI: TStringField
      FieldName = 'ECF_IDENTI'
      Size = 1
    end
    object cdsModalidadesCALC_RESTANTE: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'CALC_RESTANTE'
      DisplayFormat = '#,##0.00'
    end
    object cdsModalidadesARQUIVOTEF: TStringField
      DisplayWidth = 50
      FieldName = 'ARQUIVOTEF'
      Size = 50
    end
    object cdsModalidadesECF_INFADI: TStringField
      FieldName = 'ECF_INFADI'
      Size = 1
    end
    object cdsModalidadesAGG_PAGO: TAggregateField
      Alignment = taRightJustify
      FieldName = 'AGG_PAGO'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(VALOR)'
    end
  end
end
