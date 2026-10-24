inherited frmCadCarteiraDigital: TfrmCadCarteiraDigital
  Caption = 'Cadastro Carteira Digital'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl
    inherited tbsGeral: TTabSheet
      object Label1: TLabel
        Left = 7
        Top = 7
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo CardSE:'
      end
      object Label2: TLabel
        Left = 30
        Top = 30
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Label3: TLabel
        Left = 25
        Top = 53
        Width = 57
        Height = 14
        Caption = 'Ordena'#231#227'o:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 84
        Top = 3
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'DIG_CARDSE'
        DataSource = dtsCarDig
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 84
        Top = 26
        Width = 434
        Height = 22
        DataField = 'DIG_DESCRI'
        DataSource = dtsCarDig
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeOrdem_: TDBEditFocus
        Tag = 99
        Left = 84
        Top = 49
        Width = 40
        Height = 22
        CharCase = ecUpperCase
        DataField = 'DIG_ORDEM_'
        DataSource = dtsCarDig
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
  end
  object dtsCarDig: TDataSource
    Left = 400
    Top = 8
  end
end
