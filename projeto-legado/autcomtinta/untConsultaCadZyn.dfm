inherited frmConsultaCadZyn: TfrmConsultaCadZyn
  VertScrollBar.Range = 283
  Caption = 'Consulta Zynamix'
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
      Left = 68
      Top = 15
      Width = 120
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pr. Venda Lt. 1,000 Con.:'
    end
    object lblVenConGl: TLabel
      Left = 75
      Top = 36
      Width = 113
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pr. Venda Lt. 1,000 Dil.:'
    end
    object lblCusConLt: TLabel
      Left = 72
      Top = 58
      Width = 116
      Height = 13
      Caption = 'Pr. Custo Lt. 1,000 Con.:'
    end
    object lblCusConGl: TLabel
      Left = 80
      Top = 81
      Width = 109
      Height = 13
      Caption = 'Pr. Custo Lt. 1,000 Dil.:'
    end
    object Label3: TLabel
      Left = 459
      Top = 15
      Width = 121
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pr. Venda Gl. 3,600 Con.:'
    end
    object Label4: TLabel
      Left = 466
      Top = 36
      Width = 114
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pr. Venda Gl. 3,600 Dil.:'
    end
    object Label5: TLabel
      Left = 463
      Top = 58
      Width = 117
      Height = 13
      Caption = 'Pr. Custo Gl. 3,600 Con.:'
    end
    object Label6: TLabel
      Left = 471
      Top = 80
      Width = 110
      Height = 13
      Caption = 'Pr. Custo Gl. 3,600 Dil.:'
    end
    object edtVenConLt: TEditFocus
      Left = 193
      Top = 7
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taRightJustify
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
    object edtVenDilLt: TEditFocus
      Left = 193
      Top = 29
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taRightJustify
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
      Top = 51
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taRightJustify
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
    object edtCusDilLt: TEditFocus
      Left = 193
      Top = 73
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taRightJustify
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
    object edtVenConGl: TEditFocus
      Left = 584
      Top = 7
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taRightJustify
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
      Top = 29
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taRightJustify
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
    object edtCusConGl: TEditFocus
      Left = 584
      Top = 51
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taRightJustify
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
      Top = 73
      Width = 93
      Height = 21
      TabStop = False
      Alignment = taRightJustify
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
