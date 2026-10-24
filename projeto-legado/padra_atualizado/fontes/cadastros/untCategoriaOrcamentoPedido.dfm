inherited frmCategoriaOrcamentoPedido: TfrmCategoriaOrcamentoPedido
  Width = 640
  Height = 229
  Caption = 'Categoria para Or'#231'amento / Pedido'
  ExplicitWidth = 640
  ExplicitHeight = 229
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 156
    Width = 634
    ExplicitTop = 156
    ExplicitWidth = 634
    inherited FlwBotoes: TFlowPanel
      Width = 630
      ExplicitTop = 2
      ExplicitWidth = 630
      inherited btnPesquisa: TBitBtnLocked
        Width = 93
        ExplicitWidth = 93
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 548
      Height = 20
      ExplicitLeft = 548
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 634
    Height = 156
    StyleElements = [seFont, seBorder]
    ExplicitWidth = 634
    ExplicitHeight = 156
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 626
      ExplicitHeight = 125
      object Label1: TLabel
        Left = 51
        Top = 6
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label34: TLabel
        Left = 468
        Top = 6
        Width = 69
        Height = 14
        Cursor = crHandPoint
        Alignment = taRightJustify
        Caption = 'Cor Categoria:'
        FocusControl = dbeCorCat
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = Label34Click
      end
      object Label2: TLabel
        Left = 35
        Top = 29
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object Label8: TLabel
        Left = 90
        Top = 51
        Width = 176
        Height = 14
        Alignment = taRightJustify
        Caption = 'Categoria permitida para: Or'#231'amento'
      end
      object Label3: TLabel
        Left = 234
        Top = 75
        Width = 32
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pedido'
      end
      object ColorLabel2: TColorLabel
        Left = 313
        Top = 51
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object ColorLabel1: TColorLabel
        Left = 313
        Top = 75
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 90
        Top = 2
        Width = 88
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'CAT_CODIGO'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeCorCat: TDBEditFocus
        Tag = 50
        Left = 543
        Top = 2
        Width = 31
        Height = 22
        DataField = 'CAT_CORCAT'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        OnChange = dbeCorCatChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 90
        Top = 25
        Width = 484
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAT_DESCRI'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeEspOrc: TDBEditFocus
        Tag = 99
        Left = 271
        Top = 48
        Width = 36
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAT_ESPORC'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object dbeEspPed: TDBEditFocus
        Tag = 99
        Left = 271
        Top = 72
        Width = 36
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAT_ESPPED'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object pnlLead: TPanel
        Left = 229
        Top = 94
        Width = 378
        Height = 26
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 5
        object ColorLabel3: TColorLabel
          Left = 83
          Top = 5
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label4: TLabel
          Left = 5
          Top = 7
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'Lead'
        end
        object dbeLead: TDBEditFocus
          Tag = 99
          Left = 42
          Top = 2
          Width = 36
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CAT_LEDPER'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 184
    Width = 634
    ExplicitTop = 184
    ExplicitWidth = 634
    inherited pnlNomeForm: TPanel
      Left = 287
      ExplicitLeft = 287
    end
    inherited pnlInfo: TPanel
      Width = 287
      ExplicitWidth = 287
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 500
    Top = 12
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 452
    Top = 12
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 540
    Top = 12
  end
  object dtsTabela: TDataSource
    OnDataChange = dtsTabelaDataChange
    Left = 620
    Top = 12
  end
  object cldCores: TColorDialog
    Left = 410
    Top = 12
  end
end
