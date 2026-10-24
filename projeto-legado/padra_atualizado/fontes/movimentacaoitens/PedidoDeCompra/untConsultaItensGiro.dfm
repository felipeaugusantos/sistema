inherited frmConsultaItensGiro: TfrmConsultaItensGiro
  Left = 306
  Top = 102
  Caption = 'Consulta de Itens com Giro de Estoque'
  ClientHeight = 582
  ClientWidth = 1093
  OldCreateOrder = True
  OnActivate = FormActivate
  OnClose = FormClose
  ExplicitWidth = 1109
  ExplicitHeight = 621
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Width = 1093
    Height = 110
  end
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 1093
    ExplicitTop = 529
    ExplicitWidth = 1093
    inherited btnConfirma: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 928
      ModalResult = 2
      ExplicitLeft = 928
    end
  end
  inherited stbStatus: TStatusBar
    Top = 563
    Width = 1093
    ExplicitTop = 563
    ExplicitWidth = 1093
  end
  inherited Panel1: TPanel
    Top = 399
    Width = 1093
    ExplicitTop = 399
    ExplicitWidth = 1093
    inherited lblChave1: TLabel
      StyleElements = [seClient, seBorder]
    end
    inherited lblChave2: TLabel
      StyleElements = [seClient, seBorder]
    end
    inherited lblChave3: TLabel
      StyleElements = [seClient, seBorder]
    end
    object pnlImagem: TPanel
      Left = 936
      Top = 1
      Width = 156
      Height = 128
      Align = alRight
      Color = 16770261
      TabOrder = 4
      object pnlImgPro: TPanel
        Left = 7
        Top = 17
        Width = 144
        Height = 101
        BevelInner = bvLowered
        BorderWidth = 2
        BorderStyle = bsSingle
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object imgPro: TImage
          Left = 4
          Top = 4
          Width = 132
          Height = 89
          Align = alClient
          Center = True
          IncrementalDisplay = True
          Proportional = True
          Stretch = True
        end
        object lblErrImg: TLabel
          Left = 4
          Top = 4
          Width = 132
          Height = 89
          Align = alClient
          Alignment = taCenter
          Caption = 
            'N'#227'o foi poss'#237'vel carregar a imagem do produto. Verifique o forma' +
            'to do arquivo!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          Visible = False
          WordWrap = True
          ExplicitWidth = 131
          ExplicitHeight = 36
        end
      end
    end
  end
  object pnlGiro: TPanel [4]
    Left = 0
    Top = 165
    Width = 1093
    Height = 234
    Align = alBottom
    TabOrder = 4
    object pnlItem: TPanel
      Left = 660
      Top = 1
      Width = 432
      Height = 162
      Align = alRight
      Color = 16770261
      TabOrder = 0
      object lblSugest: TLabel
        Left = 72
        Top = 117
        Width = 46
        Height = 14
        Caption = 'Sugest'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblSaldos: TLabel
        Left = 130
        Top = 117
        Width = 49
        Height = 14
        Caption = 'Sal. F'#237'sico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblMes: TLabel
        Left = 190
        Top = 117
        Width = 20
        Height = 14
        Caption = 'Mes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 11
        Top = 6
        Width = 43
        Height = 14
        Caption = 'Pr. Custo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitMarBr1: TLabel
        Left = 72
        Top = 6
        Width = 46
        Height = 14
        Caption = 'M.Bruta 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitPreVe1: TLabel
        Left = 130
        Top = 6
        Width = 52
        Height = 14
        Caption = 'Pr.Venda 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitMarBr2: TLabel
        Left = 190
        Top = 6
        Width = 46
        Height = 14
        Caption = 'M.Bruta 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitPreVe2: TLabel
        Left = 249
        Top = 6
        Width = 52
        Height = 14
        Caption = 'Pr.Venda 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblMedia: TLabel
        Left = 11
        Top = 117
        Width = 29
        Height = 13
        Caption = 'Media'
      end
      object lblTitMarBr3: TLabel
        Left = 307
        Top = 6
        Width = 46
        Height = 14
        Caption = 'M.Bruta 3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitPreVe3: TLabel
        Left = 366
        Top = 6
        Width = 52
        Height = 14
        Caption = 'Pr.Venda 3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitMarBr4: TLabel
        Left = 72
        Top = 43
        Width = 46
        Height = 14
        Caption = 'M.Bruta 4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitPreVe4: TLabel
        Left = 130
        Top = 43
        Width = 52
        Height = 14
        Caption = 'Pr.Venda 4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitMarBr5: TLabel
        Left = 190
        Top = 43
        Width = 46
        Height = 14
        Caption = 'M.Bruta 5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitPreVe5: TLabel
        Left = 249
        Top = 43
        Width = 52
        Height = 14
        Caption = 'Pr.Venda 5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitMarBr6: TLabel
        Left = 307
        Top = 43
        Width = 46
        Height = 14
        Caption = 'M.Bruta 6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitPreVe6: TLabel
        Left = 366
        Top = 43
        Width = 52
        Height = 14
        Caption = 'Pr.Venda 6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 247
        Top = 117
        Width = 24
        Height = 14
        Caption = 'Peso'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitMarBr7: TLabel
        Left = 72
        Top = 80
        Width = 46
        Height = 14
        Caption = 'M.Bruta 7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitPreVe7: TLabel
        Left = 130
        Top = 80
        Width = 52
        Height = 14
        Caption = 'Pr.Venda 7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object dbeMes: TDBEditFocus
        Left = 189
        Top = 130
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_VENMES'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSaldos: TDBEditFocus
        Left = 129
        Top = 130
        Width = 58
        Height = 22
        TabStop = False
        DataField = 'ITE_SALFIS'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSugest: TDBEditFocus
        Left = 70
        Top = 130
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_SUGEST'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreVe1: TDBEditFocus
        Left = 129
        Top = 19
        Width = 58
        Height = 22
        TabStop = False
        DataField = 'ITE_PREVE1'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMarBr1: TDBEditFocus
        Left = 70
        Top = 19
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_MARBR1'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreCus: TDBEditFocus
        Left = 10
        Top = 19
        Width = 58
        Height = 22
        TabStop = False
        DataField = 'ITE_PRECUS'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreVe2: TDBEditFocus
        Left = 248
        Top = 19
        Width = 58
        Height = 22
        TabStop = False
        DataField = 'ITE_PREVE2'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMarBr2: TDBEditFocus
        Left = 189
        Top = 19
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_MARBR2'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtValMedia: TEditFocus
        Left = 10
        Top = 130
        Width = 58
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeMarBr3: TDBEditFocus
        Left = 365
        Top = 19
        Width = 58
        Height = 22
        TabStop = False
        DataField = 'ITE_PREVE3'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreVe3: TDBEditFocus
        Left = 306
        Top = 19
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_MARBR3'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreVe4: TDBEditFocus
        Left = 129
        Top = 56
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_PREVE4'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMarBr4: TDBEditFocus
        Left = 70
        Top = 56
        Width = 58
        Height = 22
        TabStop = False
        DataField = 'ITE_MARBR4'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMarBr5: TDBEditFocus
        Left = 189
        Top = 56
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_MARBR5'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreVe5: TDBEditFocus
        Left = 248
        Top = 56
        Width = 58
        Height = 22
        TabStop = False
        DataField = 'ITE_PREVE5'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMarBr6: TDBEditFocus
        Left = 306
        Top = 56
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_MARBR6'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreVe6: TDBEditFocus
        Left = 365
        Top = 56
        Width = 58
        Height = 22
        TabStop = False
        DataField = 'ITE_PREVE6'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePesoit: TDBEditFocus
        Left = 246
        Top = 130
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_PESOIT'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMarBr7: TDBEditFocus
        Left = 70
        Top = 93
        Width = 57
        Height = 22
        TabStop = False
        DataField = 'ITE_MARBR7'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreVe7: TDBEditFocus
        Left = 129
        Top = 93
        Width = 58
        Height = 22
        TabStop = False
        DataField = 'ITE_PREVE7'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlMeses: TPanel
      Left = 1
      Top = 1
      Width = 659
      Height = 162
      Align = alClient
      Color = 16770261
      TabOrder = 1
      object lblVendas: TLabel
        Left = 7
        Top = 7
        Width = 40
        Height = 14
        Caption = 'Vendas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblMes01: TLabel
        Left = 4
        Top = 23
        Width = 42
        Height = 14
        Caption = 'lblMes01'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes02: TLabel
        Left = 63
        Top = 23
        Width = 42
        Height = 14
        Caption = 'lblMes02'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes03: TLabel
        Left = 123
        Top = 23
        Width = 42
        Height = 14
        Caption = 'lblMes03'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes04: TLabel
        Left = 182
        Top = 23
        Width = 42
        Height = 14
        Caption = 'lblMes04'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes05: TLabel
        Left = 242
        Top = 23
        Width = 42
        Height = 14
        Caption = 'lblMes05'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes06: TLabel
        Left = 301
        Top = 23
        Width = 42
        Height = 14
        Caption = 'lblMes06'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes07: TLabel
        Left = 4
        Top = 64
        Width = 42
        Height = 14
        Caption = 'lblMes07'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes08: TLabel
        Left = 63
        Top = 64
        Width = 42
        Height = 14
        Caption = 'lblMes08'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes09: TLabel
        Left = 123
        Top = 64
        Width = 42
        Height = 14
        Caption = 'lblMes09'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes10: TLabel
        Left = 182
        Top = 64
        Width = 42
        Height = 14
        Caption = 'lblMes10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes11: TLabel
        Left = 242
        Top = 64
        Width = 41
        Height = 14
        Caption = 'lblMes11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMes12: TLabel
        Left = 301
        Top = 64
        Width = 42
        Height = 14
        Caption = 'lblMes12'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object dbeMes01: TDBEditFocus
        Left = 4
        Top = 38
        Width = 58
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes02: TDBEditFocus
        Left = 63
        Top = 38
        Width = 58
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes04: TDBEditFocus
        Left = 182
        Top = 38
        Width = 58
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes03: TDBEditFocus
        Left = 123
        Top = 38
        Width = 57
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes06: TDBEditFocus
        Left = 301
        Top = 38
        Width = 58
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes05: TDBEditFocus
        Left = 242
        Top = 38
        Width = 57
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes12: TDBEditFocus
        Left = 301
        Top = 78
        Width = 58
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes11: TDBEditFocus
        Left = 242
        Top = 78
        Width = 57
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes10: TDBEditFocus
        Left = 182
        Top = 78
        Width = 57
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes09: TDBEditFocus
        Left = 123
        Top = 78
        Width = 57
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes08: TDBEditFocus
        Left = 63
        Top = 78
        Width = 58
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes07: TDBEditFocus
        Left = 4
        Top = 78
        Width = 58
        Height = 22
        TabStop = False
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object btnMostraEstoque: TBitBtnLocked
        Left = 4
        Top = 111
        Width = 173
        Height = 22
        Caption = '[ F6 ] Mostra Estoque das lojas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 13
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        Visible = False
        OnClick = btnMostraEstoqueClick
      end
    end
    object grpUltFornecedor: TGroupBox
      Left = 1
      Top = 163
      Width = 1091
      Height = 70
      Align = alBottom
      Caption = 'Dados da '#218'ltima Compra'
      Color = 16770261
      ParentColor = False
      TabOrder = 2
      object Label13: TLabel
        Left = 9
        Top = 12
        Width = 22
        Height = 14
        Caption = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 155
        Top = 12
        Width = 56
        Height = 14
        Caption = 'Fornecedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 83
        Top = 12
        Width = 52
        Height = 14
        Caption = 'Pr. Compra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtDesForUlt: TEditFocus
        Left = 236
        Top = 27
        Width = 261
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
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
      object edtDTAULT: TEditFocus
        Left = 9
        Top = 27
        Width = 71
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPREULT: TEditFocus
        Left = 82
        Top = 27
        Width = 71
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtFORULT: TEditFocus
        Left = 155
        Top = 27
        Width = 79
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 110
    Width = 1093
    Height = 55
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
    object lblAplica: TLabel
      Left = 13
      Top = 22
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'Aplica'#231#227'o:'
    end
    object dbeAplica: TDBMemoFocus
      Left = 68
      Top = 6
      Width = 756
      Height = 43
      DataField = 'ITE_APLICA'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object imglImageList: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 472
    Top = 164
    Bitmap = {
      494C010102000500040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000020000
      000A05020138301A0D946A391FD1874925EA854626E866381ED02F190C930301
      0030000000090000000100000000000000000000000000000000000000000000
      0002000000070000000C0000001000000012000000110000000E000000080000
      0002000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000300000011341C
      0F97A65E37FAC58956FFD6A36CFFDDAF74FFDDAF73FFD6A46AFFC58955FF9C5B
      34F51A0E08730000000F00000003000000000000000000000001000000040000
      001206130D79113C29C6206A4AFF206A4AFF206B4AFF15432FD2071811840000
      0015000000050000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000200000010532E1BB9BC7B
      4CFFDDAE76FFDEB075FFDEAF74FFDEAF74FFDEB073FFDDAF74FFDEAF73FFDBAB
      71FFBD7D4DFF4E2B18B50000001000000002000000000000000501030235184E
      37DC23805BFF28AC7DFF2BC592FF2CC894FF2CC693FF29AE80FF24855FFF1547
      32D40104023D0000000700000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000008351F1295BE8052FFE0B3
      7BFFDFB075FFDEB176FFDFB278FFE0B378FFE0B279FFE0B278FFDFB278FFDFB2
      76FFDEB076FFC08252FF301C10920000000A00000003000201311D5C42ED289D
      73FF2EC896FF2DC996FF55D4ACFF67DAB5FF3ACD9DFF2FC996FF31CA99FF2AA4
      78FF1F6C4DF80104023D00000005000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000004020132AB6D45FADFB27CFFDFB2
      79FFE0B37AFFE0B57CFFE1B67DFFE2B67EFFE2B77EFFE2B77EFFE2B67DFFE0B4
      7BFFE0B47AFFDEB078FFAF6F48FB0302012F0000000A144530D02DA57BFF32CA
      99FF2DC896FF4BD2A8FF1F835BFF00663AFF44BE96FF30CB99FF30CB98FF33CC
      9CFF30AD83FF154B35D300000013000000020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000038221695CD9B6EFFE2B780FFE5BD
      89FFE7C291FFE8C393FFE8C494FFE8C594FFE8C495FFE8C495FFE8C494FFE8C3
      93FFE5BF8CFFE1B77EFFD09C6DFF2D1C118B040C085E2D8A65FF3ACD9EFF2FCA
      97FF4AD3A9FF339570FF87AF9DFFB1CFC1FF228A5FFF44D3A8FF35CF9FFF32CD
      9BFF3DD0A3FF30946FFF0718117F000000070000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000794D32D2DCB383FFE3B781FFBA86
      58FFA96F42FFAB7144FFAC7245FFB07849FFAB7144FFAD7446FFB07749FFB179
      4AFFC29161FFE4B983FFDEB17DFF74492FD0113627B63CB38CFF38CD9FFF4AD5
      A9FF42A382FF689782FFF8F1EEFFF9F3EEFF347E5CFF55C4A1FF42D5A8FF3DD3
      A4FF3BD1A4FF40BC95FF154935CD0000000B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A76D47F2E3BF8FFFE4BB84FFA56A
      3EFFF5EEE9FFFAF6F3FFFAF7F3FFFBF7F4FFFBF7F5FFFAF7F4FFFAF7F3FFFAF6
      F2FFAB7144FFE5BD87FFE5BE8BFF9F6946EE18573CDF4ACAA4FF43D2A8FF4EB3
      92FF4D8269FFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1A744EFF5FDCB8FF47D8
      ACFF46D6AAFF50D4ACFF227655F80000000E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A16C48ECE9C9A0FFE5BE89FFA56A
      3EFFE6D9D2FFE7DBD4FFE9DED7FFEAE0D9FFEAE0DAFFEBE1DBFFEBE0DBFFEEE5
      E1FFAA7043FFE7C08CFFEACA9DFFA26D48EE1E694BF265D9B8FF45D3A8FF0A66
      40FFD2D2CBFF698F76FF106A42FF72967DFFF1E8E3FF71A28BFF45A685FF5DDF
      BAFF4BD9AFFF6AE2C2FF26845FFF000000190000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007D553BD0E9CDACFFEAC796FFB784
      55FFA56A3EFFA56A3EFFA56A3EFFA56A3EFFA56A3EFFA56A3EFFA56A3EFFA56A
      3EFFB78456FFEACA99FFEBD1ADFF7F573BD418593EDC77D9BEFF51DAB1FF3CBA
      92FF086840FF2E9C75FF56DEB8FF2C9972FF72967DFFF0EAE7FF4E886BFF59BB
      9AFF5ADEB9FF7EE2C7FF257E5BF80000000C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000402E1F97DDBB9DFFEED3A9FFEECF
      A2FFEED2A5FFF0D6A9FFF1D7ABFFF1D8ADFFF1D8ADFFF1D8ADFFF1D6AAFFF0D5
      A8FFEED2A5FFEFD4A7FFE0C2A2FF36271B8F103626AB76C8B0FF61E0BCFF55DD
      B7FF58DFBAFF5BE1BDFF5DE2BEFF5EE4C1FF278C66FF688E75FFE6E1DCFF166A
      46FF5ED8B4FF83D5BDFF174E3AC6000000090000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000403022BC4916AFCF5E8CCFFEFD6
      ABFFF1D8AEFFF2DAB0FFF3DCB3FFF3DEB4FFF3DEB4FFF3DEB4FFF3DCB2FFF1DB
      B0FFF1D8ADFFF7EACDFFC1906DFA0403022E02080647429C7AFF95ECD6FF59DF
      BAFF5DE2BDFF60E4BFFF63E6C1FF66E6C5FF66E8C7FF38A17DFF1E6C49FF278B
      63FF98EFD9FF4CAC8CFF0616116D000000040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000033F2E2292D7B08CFFF8EF
      D3FFF3E0B9FFF3DFB7FFF4E1B9FFF5E3BBFFF5E2BBFFF5E2BBFFF4E1B9FFF4E2
      BDFFFAF1D5FFD9B390FF37291D8C0000000600000004134231B577C6ADFF9AEE
      D9FF64E5C0FF63E7C3FF68E7C6FF6AE8C8FF6BE9C9FF6AEAC9FF5DD6B6FF97ED
      D7FF86D3BBFF1C6149D20000000C000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000100000007684D38B8D9B3
      8FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7ECCAFFF8EED0FFF4E8
      CDFFD7AF8BFF5F4733B30000000B0000000100000001000000181E674DDA6FC1
      A8FFB5F2E3FF98F0DAFF85EDD4FF74EBCEFF88EFD6FF9CF2DDFFBAF4E7FF77CD
      B3FF258362EA0103022E00000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000073E2E
      238FCC9D76FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8B9FFE3C5A3FFBA91
      6CF21E161067000000060000000100000000000000000000000100000017154B
      38B843AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8C1FF4AB692FF1A64
      4CCB000202270000000300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      00020504032C392C218983644ACCBA8E69F1B38A67EE83644CCD3A2D228B0202
      0122000000030000000100000000000000000000000000000000000000010000
      0003020906410F3A2B9D1D6B50CF28926EEE1D6E52CF144D3BB004100C560000
      0006000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
