inherited frmConsultaCadMixVenda: TfrmConsultaCadMixVenda
  Top = 15
  VertScrollBar.Range = 241
  Caption = 'Consulta Lazzumix'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 287
  end
  inherited Panel1: TPanel
    inherited btnExecutaTarefa: TBitBtnLocked
      Caption = '[ F4 ] Cadastrar Nova F'#243'rmula'
      Visible = True
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
      Left = 70
      Top = 15
      Width = 120
      Height = 13
      Caption = 'Pr. Venda Con. Lt. 0,900:'
    end
    object lblVenConGl: TLabel
      Left = 68
      Top = 37
      Width = 121
      Height = 13
      Caption = 'Pr. Venda Con. Gl. 3,600:'
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
    object edtVenDilLt: TEditFocus
      Left = 584
      Top = 7
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
    object edtVenDilGl: TEditFocus
      Left = 584
      Top = 30
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
  end
end
