inherited frmDMPLHistoricoMovimentacao: TfrmDMPLHistoricoMovimentacao
  Height = 166
  Caption = 'Hist'#243'rico de Movimenta'#231#227'o'
  ExplicitHeight = 166
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 93
    ExplicitTop = 93
  end
  inherited pnlStatus: TPanel
    Top = 121
    ExplicitTop = 121
  end
  inherited pgcDados: TPageControl
    Height = 93
    ExplicitHeight = 93
    inherited tbsGeral: TTabSheet
      object Label1: TLabel
        Left = 31
        Top = 10
        Width = 23
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo:'
      end
      object Label2: TLabel
        Left = 3
        Top = 32
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 57
        Top = 3
        Width = 64
        Height = 22
        CharCase = ecUpperCase
        DataField = 'HST_CODIGO'
        DataSource = dtsHistMov
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 57
        Top = 28
        Width = 424
        Height = 22
        CharCase = ecUpperCase
        DataField = 'HST_DESCRI'
        DataSource = dtsHistMov
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  object dtsHistMov: TDataSource
    Left = 380
    Top = 4
  end
end
