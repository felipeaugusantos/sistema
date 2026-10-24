inherited frmEntConfPedidosPreNotaMotorola: TfrmEntConfPedidosPreNotaMotorola
  Width = 328
  Height = 280
  Caption = 'frmEntConfPedidosPreNotaMotorola'
  OnClose = FormClose
  ExplicitWidth = 328
  ExplicitHeight = 280
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 199
    Width = 312
    Height = 26
    ExplicitTop = 199
    ExplicitWidth = 312
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 256
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 308
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 37
        Caption = '[ F3 ]'
        Glyph.Data = {00000000}
        ExplicitWidth = 37
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 37
        Width = 40
        Caption = '[ F5 ]'
        Glyph.Data = {00000000}
        ExplicitLeft = 37
        ExplicitWidth = 40
      end
      object btnConfirma: TBitBtnLocked
        Left = 77
        Top = 0
        Width = 77
        Height = 22
        Caption = '[F10] Confirma'
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnSeleciona: TBitBtnLocked
        Left = 154
        Top = 0
        Width = 83
        Height = 22
        Caption = '[ ENTER] Selec.'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnSelecionaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 258
      Top = 2
      Width = 52
      Align = alRight
      Caption = 'Sair'
      Glyph.Data = {00000000}
      ExplicitLeft = 258
      ExplicitWidth = 52
    end
  end
  inherited pnlHeader: TPanel
    Width = 312
    Height = 25
    Visible = False
    ExplicitWidth = 312
    ExplicitHeight = 25
  end
  inherited pnlTail: TPanel
    Top = 151
    Width = 312
    ExplicitTop = 149
    ExplicitWidth = 312
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 65
    Width = 312
    Height = 86
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Caption = 'Documento'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESPDOC'
        Title.Caption = 'Esp.'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SERDOC'
        Title.Caption = 'Ser.'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAEMI'
        Title.Caption = 'Emiss'#227'o'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODFOR'
        Title.Caption = 'C'#243'd. Forn.'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALDOC'
        Title.Caption = 'Total Itens'
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IDEDIG'
        Title.Caption = 'Seq. Conf.'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 25
    Width = 312
    ExplicitTop = 25
    ExplicitWidth = 312
    inherited edtNumero: TEditFocus
      Left = 159
      Width = 74
      ExplicitLeft = 159
      ExplicitWidth = 74
    end
    inherited edtString: TEditFocus
      Left = 159
      Width = 74
      ExplicitLeft = 159
      ExplicitWidth = 74
    end
    inherited edtValor: TEditFocus
      Left = 159
      Width = 74
      ExplicitLeft = 159
      ExplicitWidth = 74
    end
  end
  inherited pnlStatus: TPanel
    Top = 225
    Width = 312
    ExplicitTop = 225
    ExplicitWidth = 312
    inherited pnlNomeForm: TPanel
      Left = 141
      ExplicitLeft = 141
    end
    inherited pnlInfo: TPanel
      Width = 141
      ExplicitWidth = 141
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 56
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 144
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 8
  end
  inherited qryConsulta: TUniQuery
    Left = 40
    Top = 136
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 72
    Top = 136
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 104
    Top = 136
  end
  inherited dtsConsulta: TDataSource
    Left = 136
    Top = 136
  end
end
