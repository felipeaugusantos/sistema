inherited frmConsultaCadZynVenda: TfrmConsultaCadZynVenda
  Top = 15
  VertScrollBar.Range = 241
  Caption = 'Consulta Zynamix'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 287
  end
  inherited Panel1: TPanel
    inherited btnExecutaTarefa: TBitBtnLocked
      Caption = '[ F4 ] Cadastrar Nova F'#243'rmula'
      OnClick = btnExecutaTarefaClick
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 287
    Width = 780
    Height = 59
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object lblVenConLt: TLabel
      Left = 68
      Top = 15
      Width = 120
      Height = 13
      Caption = 'Pr. Venda Lt. 1,000 Con.:'
    end
    object lblVenConGl: TLabel
      Left = 75
      Top = 36
      Width = 113
      Height = 13
      Caption = 'Pr. Venda Lt. 1,000 Dil.:'
    end
    object Label3: TLabel
      Left = 459
      Top = 15
      Width = 121
      Height = 13
      Caption = 'Pr. Venda Gl. 3,600 Con.:'
    end
    object Label4: TLabel
      Left = 466
      Top = 36
      Width = 114
      Height = 13
      Caption = 'Pr. Venda Gl. 3,600 Dil.:'
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
      Top = 30
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
    object edtVenConGl: TEditFocus
      Left = 584
      Top = 7
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
    object edtVenDilGl: TEditFocus
      Left = 584
      Top = 30
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
  end
end
