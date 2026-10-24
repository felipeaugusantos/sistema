inherited frmEntConfPedidosMotorola: TfrmEntConfPedidosMotorola
  Width = 356
  Height = 280
  Caption = 'Selecione os pedidos para confer'#234'ncia'
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 356
  ExplicitHeight = 280
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 199
    Width = 340
    Height = 26
    ExplicitTop = 199
    ExplicitWidth = 340
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 289
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 336
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 53
        Caption = '[F3]'
        ExplicitWidth = 53
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 53
        Width = 45
        Caption = '[F5]'
        ExplicitLeft = 53
        ExplicitWidth = 45
      end
      object btnConfirma: TBitBtnLocked
        Left = 98
        Top = 0
        Width = 78
        Height = 22
        Caption = '[F10] Confirma'
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 2
      end
      object btnSeleciona: TBitBtnLocked
        Left = 176
        Top = 0
        Width = 100
        Height = 22
        Caption = '[ ENTER] Seleciona'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnSelecionaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 291
      Top = 2
      Width = 47
      Align = alRight
      Caption = 'Sair'
      ExplicitLeft = 298
      ExplicitWidth = 47
    end
  end
  inherited pnlHeader: TPanel
    Width = 340
    Height = 25
    Visible = False
    ExplicitWidth = 340
    ExplicitHeight = 25
  end
  inherited pnlTail: TPanel
    Top = 151
    Width = 340
    ExplicitTop = 149
    ExplicitWidth = 340
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 65
    Width = 340
    Height = 86
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
        Width = 68
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTGER'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Pedido'
        Width = 62
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 25
    Width = 340
    ExplicitTop = 25
    ExplicitWidth = 340
    inherited edtString: TEditFocus
      Left = 161
      Top = 7
      Width = 121
      ExplicitLeft = 161
      ExplicitTop = 7
      ExplicitWidth = 121
    end
  end
  inherited pnlStatus: TPanel
    Top = 225
    Width = 340
    Visible = False
    ExplicitTop = 225
    ExplicitWidth = 340
    inherited pnlNomeForm: TPanel
      Left = 169
      ExplicitLeft = 169
    end
    inherited pnlInfo: TPanel
      Width = 169
      ExplicitWidth = 169
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 296
    Top = 112
  end
end
