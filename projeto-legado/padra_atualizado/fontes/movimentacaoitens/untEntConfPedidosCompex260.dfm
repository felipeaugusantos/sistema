inherited frmEntConfPedidosCompex260: TfrmEntConfPedidosCompex260
  Width = 244
  Height = 280
  BorderStyle = bsDialog
  Caption = 'Selecione os pedidos para confer'#234'ncia'
  OnClose = FormClose
  ExplicitWidth = 244
  ExplicitHeight = 280
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 209
    Width = 238
    Height = 26
    ExplicitTop = 209
    ExplicitWidth = 238
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 202
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 234
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 32
        Hint = 'Muda ordem'
        Caption = '[F3]'
        Glyph.Data = {00000000}
        ParentShowHint = False
        ShowHint = True
        ExplicitWidth = 32
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 32
        Width = 29
        Hint = 'Pesquisar'
        Caption = '[F5]'
        Glyph.Data = {00000000}
        ParentShowHint = False
        ShowHint = True
        ExplicitLeft = 32
        ExplicitWidth = 29
      end
      object btnConfirma: TBitBtnLocked
        Left = 61
        Top = 0
        Width = 58
        Height = 22
        Caption = '[F10] Conf.'
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 2
      end
      object btnSeleciona: TBitBtnLocked
        Left = 119
        Top = 0
        Width = 68
        Height = 22
        Caption = '[ ENTER] Sel.'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnSelecionaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 204
      Top = 2
      Width = 32
      Align = alRight
      Caption = 'Sair'
      Glyph.Data = {00000000}
      ExplicitLeft = 205
      ExplicitWidth = 32
    end
  end
  inherited pnlHeader: TPanel
    Width = 238
    Height = 25
    Visible = False
    ExplicitWidth = 238
    ExplicitHeight = 25
  end
  inherited pnlTail: TPanel
    Top = 161
    Width = 238
    ExplicitTop = 159
    ExplicitWidth = 238
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 65
    Width = 238
    Height = 96
    Columns = <
      item
        Expanded = False
        FieldName = 'PCG_NUMPED'
        Title.Caption = 'Pedido'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CODEMP'
        Title.Caption = 'Emp.'
        Width = 29
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CODFOR'
        Title.Caption = 'Fornecedor'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DTAPED'
        Title.Caption = 'Data Pedido'
        Width = 72
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTGER'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Pedido'
        Width = 73
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 25
    Width = 238
    ExplicitTop = 25
    ExplicitWidth = 238
    inherited lblPesquisa: TLabel
      Width = 27
      Caption = '&Pesq.'
      ExplicitWidth = 27
    end
    inherited lblNomeCampo: TLabel
      Left = 41
      ExplicitLeft = 41
    end
    inherited edtData: TMaskEditFocus
      Left = 121
      ExplicitLeft = 121
    end
    inherited edtNumero: TEditFocus
      Left = 121
      ExplicitLeft = 121
    end
    inherited edtString: TEditFocus
      Left = 121
      Width = 101
      ExplicitLeft = 121
      ExplicitWidth = 101
    end
  end
  inherited pnlStatus: TPanel
    Top = 235
    Width = 238
    Visible = False
    ExplicitTop = 235
    ExplicitWidth = 238
    inherited pnlNomeForm: TPanel
      Left = 67
      ExplicitLeft = 67
    end
    inherited pnlInfo: TPanel
      Width = 67
      ExplicitWidth = 67
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 136
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 8
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 16
    Top = 104
  end
  inherited qryConsulta: TUniQuery
    Left = 144
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 96
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 56
    Top = 136
  end
  inherited dtsConsulta: TDataSource
    Left = 96
    Top = 136
  end
end
