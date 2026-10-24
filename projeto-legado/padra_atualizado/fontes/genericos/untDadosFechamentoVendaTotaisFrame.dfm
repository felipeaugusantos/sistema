object fraDadosFechamentoVendaTotaisFrame: TfraDadosFechamentoVendaTotaisFrame
  Left = 0
  Top = 0
  Width = 689
  Height = 127
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 689
    Height = 122
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblBaseICMS: TLabel
      Left = 47
      Top = 8
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'Base ICMS:'
    end
    object lblBasIpi: TLabel
      Left = 58
      Top = 31
      Width = 44
      Height = 13
      Alignment = taRightJustify
      Caption = 'Base IPI:'
    end
    object lblBaseST: TLabel
      Left = 425
      Top = 8
      Width = 42
      Height = 13
      Alignment = taRightJustify
      Caption = 'Base ST:'
    end
    object lblVlrICMS: TLabel
      Left = 199
      Top = 8
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object lblValIpi: TLabel
      Left = 199
      Top = 31
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object lblVlrST: TLabel
      Left = 573
      Top = 8
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object lblBasIss: TLabel
      Left = 421
      Top = 31
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Base ISS:'
    end
    object lblValIss: TLabel
      Left = 573
      Top = 31
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object lblAlqIcm: TLabel
      Left = 325
      Top = 8
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = 'Alq Icm:'
      Visible = False
    end
    object lblCodSit: TLabel
      Left = 341
      Top = 31
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'CST:'
      Visible = False
    end
    object lblBaseFCPST: TLabel
      Left = 38
      Top = 54
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Base FCP ST:'
    end
    object lblVlrFCPST: TLabel
      Left = 199
      Top = 54
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object lblAlqFCPST: TLabel
      Left = 308
      Top = 54
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Alq FCP ST:'
    end
    object lblPerFCP: TLabel
      Left = 426
      Top = 54
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Alq FCP:'
      Visible = False
    end
    object lblVlrFCP: TLabel
      Left = 551
      Top = 54
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor FCP:'
      Visible = False
    end
    object edtBasIcm: TEditFocus
      Tag = 99
      Left = 104
      Top = 4
      Width = 80
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtBasIpi: TEditFocus
      Tag = 99
      Left = 104
      Top = 27
      Width = 80
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtBasRet: TEditFocus
      Tag = 99
      Left = 469
      Top = 4
      Width = 86
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValIcm: TEditFocus
      Tag = 99
      Left = 229
      Top = 4
      Width = 72
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValIpi: TEditFocus
      Tag = 99
      Left = 229
      Top = 27
      Width = 72
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValRet: TEditFocus
      Tag = 99
      Left = 603
      Top = 4
      Width = 81
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtBasIss: TEditFocus
      Tag = 99
      Left = 469
      Top = 27
      Width = 86
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValIss: TEditFocus
      Tag = 99
      Left = 603
      Top = 27
      Width = 81
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtAlqIcm: TEditFocus
      Tag = 99
      Left = 366
      Top = 4
      Width = 41
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCodSit: TEditFocus
      Tag = 99
      Left = 366
      Top = 27
      Width = 41
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtBasFCPST: TEditFocus
      Tag = 99
      Left = 104
      Top = 50
      Width = 80
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValFCPST: TEditFocus
      Tag = 99
      Left = 229
      Top = 50
      Width = 72
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtAlqFCPST: TEditFocus
      Tag = 99
      Left = 366
      Top = 50
      Width = 41
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPerFCP: TEditFocus
      Tag = 99
      Left = 469
      Top = 50
      Width = 41
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 13
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtVlrFCP: TEditFocus
      Tag = 99
      Left = 603
      Top = 50
      Width = 81
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 14
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object pnlPisCofinsDif: TPanel
      Left = 0
      Top = 97
      Width = 689
      Height = 25
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 15
      object lblCstIpi: TLabel
        Left = 62
        Top = 10
        Width = 40
        Height = 13
        Alignment = taRightJustify
        Caption = 'CST IPI:'
        Visible = False
      end
      object lblCstPis: TLabel
        Left = 185
        Top = 10
        Width = 42
        Height = 13
        Alignment = taRightJustify
        Caption = 'CST PIS:'
        Visible = False
      end
      object lblCstCof: TLabel
        Left = 300
        Top = 10
        Width = 64
        Height = 13
        Alignment = taRightJustify
        Caption = 'CST COFINS:'
        Visible = False
      end
      object lblPerDif: TLabel
        Left = 416
        Top = 10
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = '% Per.Dif:'
        Visible = False
      end
      object lblValDif: TLabel
        Left = 533
        Top = 10
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'Valor Diferido:'
        Visible = False
      end
      object edtCstIpi: TEditFocus
        Tag = 99
        Left = 104
        Top = 2
        Width = 41
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtCstPis: TEditFocus
        Tag = 99
        Left = 229
        Top = 2
        Width = 41
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 1
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtCstCof: TEditFocus
        Tag = 99
        Left = 366
        Top = 2
        Width = 41
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtPerDif: TEditFocus
        Tag = 99
        Left = 469
        Top = 2
        Width = 41
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValDif: TEditFocus
        Tag = 99
        Left = 603
        Top = 2
        Width = 81
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        Visible = False
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
    object pnlImpostosReforma: TPanel
      Left = 0
      Top = 72
      Width = 689
      Height = 25
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 16
      object Label1: TLabel
        Left = 53
        Top = 10
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'Base CBS:'
      end
      object Label2: TLabel
        Left = 166
        Top = 10
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vlr CBS:'
      end
      object Label3: TLabel
        Left = 273
        Top = 10
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'Base IBS:'
      end
      object Label4: TLabel
        Left = 383
        Top = 10
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vlr IBS:'
      end
      object Label5: TLabel
        Left = 487
        Top = 10
        Width = 40
        Height = 13
        Alignment = taRightJustify
        Caption = 'Base IS:'
      end
      object Label6: TLabel
        Left = 593
        Top = 10
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vlr IS:'
      end
      object edtBaseCBS: TEditFocus
        Left = 104
        Top = 2
        Width = 60
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValorCBS: TEditFocus
        Left = 206
        Top = 2
        Width = 60
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtBaseIBS: TEditFocus
        Left = 321
        Top = 2
        Width = 60
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValorIBS: TEditFocus
        Left = 420
        Top = 2
        Width = 60
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtBaseIS: TEditFocus
        Left = 529
        Top = 2
        Width = 60
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValorIS: TEditFocus
        Left = 624
        Top = 2
        Width = 60
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
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
end
