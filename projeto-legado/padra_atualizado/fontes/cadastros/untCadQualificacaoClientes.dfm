inherited frmCadQualificacaoClientes: TfrmCadQualificacaoClientes
  Caption = 'Tabela de Qualifica'#231#227'o de Clientes'
  PixelsPerInch = 96
  TextHeight = 14
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 258
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 51
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDesEti: TLabel
      Left = 24
      Top = 50
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qualifica'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 9
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'QUA_CODQUA'
      DataSource = dtsCadQua
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQualificacao: TDBMemoFocus
      Tag = 99
      Left = 93
      Top = 47
      Width = 448
      Height = 170
      DataField = 'QUA_DESQUA'
      DataSource = dtsCadQua
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 840
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object dtsCadQua: TDataSource
    Left = 448
    Top = 176
  end
end
