inherited frmConsultaPedCom: TfrmConsultaPedCom
  Left = 106
  Top = 171
  Width = 972
  Height = 625
  Caption = 'Pedidos de Compra'
  OnClose = FormClose
  ExplicitWidth = 972
  ExplicitHeight = 625
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 543
    Width = 956
    ExplicitTop = 543
    ExplicitWidth = 956
    DesignSize = (
      956
      28)
    inherited btnSair: TBitBtnLocked
      Left = 883
      ModalResult = 2
      ExplicitLeft = 883
    end
    object btnTransf: TBitBtnLocked
      Left = 760
      Top = 3
      Width = 110
      Height = 22
      Caption = '[F10] &Transfere'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      ModalResult = 1
      TabOrder = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 571
    Width = 956
    ExplicitTop = 571
    ExplicitWidth = 956
    inherited pnlNomeForm: TPanel
      Left = 785
      ExplicitLeft = 785
    end
    inherited pnlInfo: TPanel
      Width = 785
      ExplicitWidth = 785
    end
  end
  inherited pnlHeader: TPanel
    Width = 956
    Visible = False
    ExplicitWidth = 956
  end
  inherited pnlTail: TPanel
    Top = 495
    Width = 956
    ExplicitTop = 495
    ExplicitWidth = 956
  end
  inherited dbgConsulta: TDBGridCitel
    Width = 956
    Height = 398
    Columns = <
      item
        Expanded = False
        FieldName = 'CANCEL'
        Title.Caption = 'Cancelado'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_NUMPED'
        Title.Caption = 'Pedido'
        Width = 47
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CODEMP'
        Title.Caption = 'Emp.'
        Width = 33
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CODFOR'
        Title.Caption = 'C'#243'd.Forn.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_NOMFOR'
        Title.Caption = 'Fornecedor'
        Width = 187
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DTAPED'
        Title.Caption = 'Data Pedido'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DTAENT'
        Title.Caption = 'Data Entrega'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CONPAG'
        Title.Caption = 'Cond. Pagamento'
        Width = 113
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total itens'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTIPI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total IPI'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTSUB'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Sub.'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_VALFRE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total frete'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTGER'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total pedido'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_EMPDES'
        Title.Caption = 'Emp.Destino'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Width = 956
    ExplicitWidth = 956
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 224
  end
  inherited qryConsulta: TUniQuery
    Left = 112
    Top = 224
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 144
    Top = 224
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 176
    Top = 224
  end
  inherited dtsConsulta: TDataSource
    Left = 208
    Top = 224
  end
end
