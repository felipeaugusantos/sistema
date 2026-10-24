inherited frmBaixaOrdProdIndustrialTipoBaixa: TfrmBaixaOrdProdIndustrialTipoBaixa
  Width = 487
  Height = 246
  Caption = 'Tipo Baixa Ordem de Produ'#231#227'o Industrial'
  ExplicitWidth = 487
  ExplicitHeight = 246
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 175
    Width = 481
    TabOrder = 1
    ExplicitTop = 158
    ExplicitWidth = 481
    inherited FlwBotoes: TFlowPanel
      Width = 477
      ExplicitTop = 2
      ExplicitWidth = 477
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 398
      ExplicitLeft = 398
    end
  end
  inherited pnlStatus: TPanel
    Top = 201
    Width = 481
    TabOrder = 2
    ExplicitTop = 184
    ExplicitWidth = 481
    inherited pnlNomeForm: TPanel
      Left = 310
      ExplicitLeft = 310
    end
    inherited pnlInfo: TPanel
      Width = 310
      ExplicitWidth = 310
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 481
    Height = 175
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 158
    object gpbTipo: TGroupBox
      Left = 8
      Top = 6
      Width = 297
      Height = 72
      TabOrder = 0
      object rdbAcabado: TRadioButton
        Left = 24
        Top = 8
        Width = 217
        Height = 17
        Caption = 'Envasar totalmente em produto acabado'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rdbAcabadoClick
      end
      object rdbResiduo: TRadioButton
        Left = 24
        Top = 28
        Width = 171
        Height = 17
        Caption = 'Envasar totalmente em res'#237'duo'
        TabOrder = 1
        OnClick = rdbResiduoClick
      end
      object rdbAcabadoResiduo: TRadioButton
        Left = 24
        Top = 48
        Width = 252
        Height = 17
        Caption = 'Envasar parte produto acabado e parte res'#237'duo'
        TabOrder = 2
        OnClick = rdbAcabadoResiduoClick
      end
    end
    object pnlResiduo: TPanel
      Left = 1
      Top = 86
      Width = 479
      Height = 88
      Align = alBottom
      TabOrder = 1
      object pnlLote: TPanel
        Left = 1
        Top = 31
        Width = 477
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = 27
        object Label12: TLabel
          Left = 43
          Top = 6
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'Lote:'
        end
        object edtLote: TEditFocus
          Tag = 99
          Left = 69
          Top = 3
          Width = 192
          Height = 22
          Alignment = taRightJustify
          Color = clWhite
          TabOrder = 0
          OnKeyPress = edtLoteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlProduto: TPanel
        Left = 1
        Top = 1
        Width = 477
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 25
          Top = 11
          Width = 42
          Height = 14
          Caption = 'Residuo:'
        end
        object edtDesProdutoResiduo: TEditFocus
          Left = 122
          Top = 8
          Width = 346
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtProdutoResiduo: TEditFocus
          Tag = 99
          Left = 69
          Top = 8
          Width = 51
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 1
          OnKeyPress = edtProdutoResiduoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
      end
      object pnlQuantidade: TPanel
        Left = 1
        Top = 56
        Width = 477
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitTop = 52
        object Label2: TLabel
          Left = 9
          Top = 6
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade:'
        end
        object edtQtdResiduo: TEditFocus
          Tag = 99
          Left = 69
          Top = 3
          Width = 90
          Height = 22
          Alignment = taRightJustify
          Color = clWhite
          MaxLength = 10
          TabOrder = 0
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 10
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 192
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
  end
end
