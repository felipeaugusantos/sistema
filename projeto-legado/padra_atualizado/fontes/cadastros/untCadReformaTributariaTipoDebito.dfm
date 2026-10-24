inherited frmCadReformaTributariaTipoDebito: TfrmCadReformaTributariaTipoDebito
  Height = 230
  Caption = 'Reforma Tribut'#225'ria Tipo de D'#233'bito'
  ExplicitHeight = 230
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 157
    ExplicitTop = 157
  end
  inherited pnlStatus: TPanel
    Top = 185
    ExplicitTop = 185
  end
  inherited pgcDados: TPageControl
    Height = 157
    ExplicitHeight = 157
  end
  object pnlPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 157
    Align = alClient
    TabOrder = 3
    object lblCodigo: TLabel
      Left = 12
      Top = 13
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
    end
    object lblDescr: TLabel
      Left = 12
      Top = 63
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 12
      Top = 30
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DEB_CODIGO'
      DataSource = dtsDados
      Enabled = False
      MaxLength = 2
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object dbeDescr: TDBMemoFocus
      Tag = 99
      Left = 12
      Top = 81
      Width = 509
      Height = 60
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'DEB_DESCRI'
      DataSource = dtsDados
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object dtsDados: TDataSource
    Left = 80
    Top = 88
  end
end
