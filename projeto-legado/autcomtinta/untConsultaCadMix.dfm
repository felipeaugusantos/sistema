inherited frmConsultaCadMix: TfrmConsultaCadMix
  VertScrollBar.Range = 283
  Caption = 'Consulta Lazzumix'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 244
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 244
    Width = 780
    Height = 102
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object lblVenConLt: TLabel
      Left = 69
      Top = 15
      Width = 120
      Height = 13
      Caption = 'Pr. Venda Con. Lt. 0,900:'
    end
    object lblVenConGl: TLabel
      Left = 67
      Top = 37
      Width = 121
      Height = 13
      Caption = 'Pr. Venda Con. Gl. 3,600:'
    end
    object lblCusConLt: TLabel
      Left = 74
      Top = 59
      Width = 116
      Height = 13
      Caption = 'Pr. Custo Con. Lt. 0,900:'
    end
    object lblCusConGl: TLabel
      Left = 72
      Top = 82
      Width = 117
      Height = 13
      Caption = 'Pr. Custo Con. Gl. 3,600:'
    end
    object lblVenDilLt: TLabel
      Left = 462
      Top = 15
      Width = 83
      Height = 13
      Caption = 'Pr. Venda Dil. Lt.:'
    end
    object lblVenDilGl: TLabel
      Left = 460
      Top = 37
      Width = 84
      Height = 13
      Caption = 'Pr. Venda Dil. Gl.:'
    end
    object lblCusDilLt: TLabel
      Left = 466
      Top = 59
      Width = 79
      Height = 13
      Caption = 'Pr. Custo Dil. Lt.:'
    end
    object lblCusDilGl: TLabel
      Left = 464
      Top = 82
      Width = 80
      Height = 13
      Caption = 'Pr. Custo Dil. Gl.:'
    end
    object edtVenConLt: TEditFocus
      Left = 193
      Top = 7
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
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
    object edtVenConGl: TEditFocus
      Left = 193
      Top = 30
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
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
    object edtCusConLt: TEditFocus
      Left = 193
      Top = 52
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCusConGl: TEditFocus
      Left = 193
      Top = 74
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
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
    object edtVenDilLt: TEditFocus
      Left = 584
      Top = 7
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
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
    object edtVenDilGl: TEditFocus
      Left = 584
      Top = 30
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
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
    object edtCusDilLt: TEditFocus
      Left = 584
      Top = 52
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
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
    object edtCusDilGl: TEditFocus
      Left = 584
      Top = 74
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      TabOrder = 7
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
end
