object fraGerarPixBoleto: TfraGerarPixBoleto
  Left = 0
  Top = 0
  Width = 604
  Height = 20
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlChavePix: TPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 20
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblGerarPix: TLabel
      Left = 3
      Top = 3
      Width = 129
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Gerar boletos Pix QRCode:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblGerarPixSN: TColorLabel
      Left = 158
      Top = 3
      Width = 54
      Height = 13
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblChavePix: TLabel
      Left = 270
      Top = 3
      Width = 104
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Chave Pix da Conta:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object edtGerarPix: TEditFocus
      Tag = 99
      Left = 136
      Top = 0
      Width = 17
      Height = 19
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 0
      Text = 'N'
      OnChange = edtGerarPixChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object cmbChavePix: TcxLookupComboBox
      Left = 373
      Top = 0
      Properties.DropDownAutoSize = True
      Properties.KeyFieldNames = 'AUTOINCREM'
      Properties.ListColumns = <>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dtsChavesPix
      Style.LookAndFeel.Kind = lfOffice11
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 1
      Width = 225
    end
  end
  object dtsChavesPix: TDataSource
    AutoEdit = False
    Left = 312
    Top = 136
  end
end
