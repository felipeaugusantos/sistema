inherited frmEntConfPedidos: TfrmEntConfPedidos
  Left = 137
  Top = 157
  Width = 1036
  Height = 565
  Caption = 'Selecione os pedidos para confer'#234'ncia'
  ExplicitWidth = 1036
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 484
    Width = 1020
    Height = 26
    ExplicitTop = 484
    ExplicitWidth = 1020
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 916
      Height = 22
      ExplicitWidth = 916
      ExplicitHeight = 22
      inherited btnPesquisar: TBitBtnLocked
        Width = 104
        ExplicitWidth = 104
      end
      object btnConfirma: TBitBtnLocked
        Left = 222
        Top = 0
        Width = 100
        Height = 22
        Caption = '[ F10 ] Confirma'
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 2
      end
      object btnSeleciona: TBitBtnLocked
        Left = 322
        Top = 0
        Width = 143
        Height = 22
        Caption = '[ ENTER/ SPACE] Seleciona'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnSelecionaClick
      end
      object btnItensPend: TBitBtnLocked
        Left = 465
        Top = 0
        Width = 160
        Height = 22
        Caption = '[F11] Mostrar itens pendentes'
        TabOrder = 4
        OnClick = btnItensPendClick
      end
      object btnSelTodos: TBitBtnLocked
        Left = 625
        Top = 0
        Width = 154
        Height = 22
        Caption = '[ F6 ] Marca/Desmarca todos'
        NumGlyphs = 2
        TabOrder = 5
        OnClick = btnSelTodosClick
      end
      object btnReqAssoc: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 142
        Height = 22
        Caption = 'Requisi'#231#245'es Associadas'
        NumGlyphs = 2
        TabOrder = 6
        OnClick = btnReqAssocClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 918
      Top = 2
      Width = 100
      Align = alRight
      ModalResult = 2
      ExplicitLeft = 918
      ExplicitTop = 2
      ExplicitWidth = 100
    end
  end
  inherited pnlStatus: TPanel
    Top = 510
    Width = 1020
    ExplicitTop = 510
    ExplicitWidth = 1020
    inherited pnlNomeForm: TPanel
      Left = 849
      ExplicitLeft = 849
    end
    inherited pnlInfo: TPanel
      Width = 849
      ExplicitWidth = 849
    end
  end
  inherited pnlHeader: TPanel
    Width = 1020
    Height = 33
    Visible = False
    ExplicitWidth = 1020
    ExplicitHeight = 33
  end
  inherited pnlTail: TPanel
    Top = 360
    Width = 1020
    Height = 124
    Visible = True
    ExplicitTop = 360
    ExplicitWidth = 1020
    ExplicitHeight = 124
    object shpGarantia: TShape
      Left = 4
      Top = 3
      Width = 16
      Height = 16
      Brush.Color = clRed
    end
    object Label1: TLabel
      Left = 26
      Top = 4
      Width = 404
      Height = 14
      Caption = 
        'Pedido referente a garantia enviada ao fornecedor (Aguardando Re' +
        'torno).'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 4
      Top = 21
      Width = 481
      Height = 42
      Caption = 
        'Permitir a sele'#231#227'o de pedidos de compra cujo fornecedor seja dif' +
        'erente do XML (por'#233'm com CNPJ do mesmo grupo de empresas). Lembr' +
        'ando que, nesse caso, ser'#225' poss'#237'vel trocar o fornecedor do pedid' +
        'o automaticamente:'
      WordWrap = True
    end
    object rbnExibirPerguta: TRadioButton
      Left = 4
      Top = 65
      Width = 146
      Height = 18
      Caption = 'Exibir pergunta'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbnExibirPergutaClick
    end
    object rbnSemprePermitirSelecao: TRadioButton
      Left = 4
      Top = 81
      Width = 146
      Height = 18
      Caption = 'Sempre permitir sele'#231#227'o'
      TabOrder = 1
      OnClick = rbnExibirPergutaClick
    end
    object rbnNaoPermitirSelecao: TRadioButton
      Left = 4
      Top = 97
      Width = 146
      Height = 18
      Caption = 'N'#227'o permitir sele'#231#227'o'
      TabOrder = 2
      OnClick = rbnExibirPergutaClick
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 73
    Width = 1020
    Height = 287
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'PCG_NUMPED'
        Title.Caption = 'Pedido'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_INDCON'
        ReadOnly = True
        Title.Caption = 'Dt In. Conf.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_INHCON'
        Title.Caption = 'Hr In. Conf.'
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
        FieldName = 'PCG_CODEMP'
        Title.Caption = 'Emp.'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CODFOR'
        Title.Caption = 'C'#243'd.For.'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_NOMFOR'
        Title.Caption = 'Fornecedor'
        Width = 137
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DTAPED'
        Title.Caption = 'Dta.Pedido'
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DTAENT'
        Title.Caption = 'Prev.Entrega'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CONPAG'
        Title.Caption = 'Cond.Pagamento'
        Width = 89
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Itens'
        Width = 95
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTIPI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total IPI'
        Width = 95
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTGER'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Pedido'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EM_DOLAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Em d'#243'lar'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DOCORI'
        Title.Caption = 'Doc. Orig.'
        Width = 134
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRE_NOTAS'
        Title.Caption = 'Notas Vinculadas'
        Width = 300
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 33
    Width = 1020
    ExplicitTop = 33
    ExplicitWidth = 1020
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 248
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 280
  end
end
