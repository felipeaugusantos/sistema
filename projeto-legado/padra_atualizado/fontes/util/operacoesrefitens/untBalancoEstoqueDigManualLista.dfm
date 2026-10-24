inherited frmBalancoEstoqueDigManualLista: TfrmBalancoEstoqueDigManualLista
  Left = 235
  Top = 280
  Width = 820
  Align = alClient
  Caption = 'frmBalancoEstoqueDigManualLista'
  ExplicitWidth = 820
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 243
    Width = 804
    Height = 29
    ExplicitTop = 243
    ExplicitWidth = 792
    ExplicitHeight = 29
    DesignSize = (
      804
      29)
    object shaDig: TShape [0]
      Left = 102
      Top = 7
      Width = 14
      Height = 14
      Brush.Color = clMoneyGreen
    end
    object Label1: TLabel [1]
      Left = 8
      Top = 6
      Width = 90
      Height = 16
      Caption = 'Digitados agora'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 800
      Height = 25
      ExplicitWidth = 788
      ExplicitHeight = 25
    end
    inherited btnSair: TBitBtnLocked
      Left = 583
      Width = 94
      Visible = False
      ExplicitLeft = 571
      ExplicitWidth = 94
    end
    object btnZerCon: TBitBtnLocked
      Left = 430
      Top = 3
      Width = 139
      Height = 22
      Caption = '[Del] Limpa contagem'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnZerConClick
    end
  end
  inherited pnlStatus: TPanel
    Width = 804
    Visible = False
    ExplicitWidth = 792
    inherited pnlNomeForm: TPanel
      Left = 633
      ExplicitLeft = 621
    end
    inherited pnlInfo: TPanel
      Width = 633
      ExplicitWidth = 621
    end
    inherited pnlBotoesTrace: TPanel
      inherited btnPausarTrace: TSpeedButton
        ExplicitHeight = 12
      end
      inherited btnSalvarTrace: TSpeedButton
        ExplicitHeight = 12
      end
      inherited btnViewerTrace: TSpeedButton
        ExplicitHeight = 12
      end
    end
  end
  inherited pnlHeader: TPanel
    Width = 804
    Visible = False
    ExplicitWidth = 792
  end
  inherited pnlTail: TPanel
    Top = 195
    Width = 804
    Visible = True
    ExplicitTop = 195
    ExplicitWidth = 792
    object lblObsSaldo: TLabel
      Left = 424
      Top = 27
      Width = 324
      Height = 14
      Caption = '* Diferen'#231'as de saldo calculadas no momento da contagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object rdgMostrar: TRadioGroup
      Left = 8
      Top = 4
      Width = 393
      Height = 39
      Caption = 'Mostrar'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'todos com saldo de contagem '
        'apenas os digitados agora')
      TabOrder = 0
      OnClick = rdgMostrarClick
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Width = 804
    Height = 98
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'd.Item'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_NUMLOT'
        Title.Caption = 'Lote'
        Width = 94
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOCFIS'
        Title.Caption = 'Localiza'#231#227'o F'#237'sica'
        Width = 116
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_SALCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo Cont. Acumulada'
        Width = 118
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_DIFSAL'
        Title.Alignment = taRightJustify
        Title.Caption = 'Diferen'#231'a Saldo*'
        Width = 88
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_GMLCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Cont. Acumul. (Gr/ML)'
        Width = 113
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_DIF_ML'
        Title.Alignment = taRightJustify
        Title.Caption = 'Diferen'#231'a (Gr/ML)*'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_ORDCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Ordem Contagem'
        Width = 89
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDPED'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. em Pedido '
        Width = 105
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Width = 804
    ExplicitWidth = 792
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
    Top = 24
  end
  inherited qryConsulta: TUniQuery
    Top = 8
  end
  inherited dspConsulta: TUniDataSetProvider
    Top = 8
  end
  inherited cdsConsulta: TUniClientDataSet
    Top = 8
  end
  inherited dtsConsulta: TDataSource
    Top = 8
  end
end
