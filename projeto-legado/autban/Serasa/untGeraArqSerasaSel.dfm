inherited frmGeraArqSerasaSel: TfrmGeraArqSerasaSel
  Left = 232
  Top = 250
  Width = 937
  Height = 549
  BorderStyle = bsNone
  Caption = 'frmGeraArqSerasaSel'
  Position = poMainFormCenter
  ExplicitWidth = 937
  ExplicitHeight = 549
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 507
    Width = 937
    Height = 26
    TabOrder = 1
    ExplicitTop = 507
    ExplicitWidth = 937
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 838
      Height = 22
      ExplicitWidth = 838
      ExplicitHeight = 22
      object btnOrdem: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F3 ] Muda Ordem'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnOrdemClick
        OnKeyUp = btnOrdemKeyUp
      end
      object btnBusca: TBitBtnLocked
        Left = 120
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F5] Inicia Busca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnBuscaClick
        OnKeyUp = btnOrdemKeyUp
      end
      object btnProximo: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F6] Localiza Pr'#243'ximo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnProximoClick
        OnKeyUp = btnOrdemKeyUp
      end
      object btnSelTodos: TBitBtnLocked
        Left = 360
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F7 ] Marcar Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnSelTodosClick
        OnKeyUp = btnOrdemKeyUp
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 480
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F8 ]Desmarcar Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnDesmarcaTodosClick
        OnKeyUp = btnOrdemKeyUp
      end
      object btnConfirma: TBitBtnLocked
        Left = 600
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F10 ] Confirma'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btnConfirmaClick
        OnKeyUp = btnOrdemKeyUp
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 840
      Top = 2
      Width = 95
      Align = alRight
      Caption = '[ESC] Sair'
      OnKeyUp = btnOrdemKeyUp
      ExplicitLeft = 840
      ExplicitTop = 2
      ExplicitWidth = 95
    end
  end
  inherited pnlStatus: TPanel
    Top = 533
    Width = 937
    TabOrder = 2
    ExplicitTop = 533
    ExplicitWidth = 937
    inherited pnlNomeForm: TPanel
      Left = 766
      ExplicitLeft = 766
    end
    inherited pnlInfo: TPanel
      Width = 766
      ExplicitWidth = 766
    end
  end
  object pnlDadosDup: TPanel [2]
    Left = 552
    Top = 22
    Width = 385
    Height = 424
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object lblCliente: TLabel
      Left = 26
      Top = 22
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Nome: TLabel
      Left = 31
      Top = 42
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 17
      Top = 64
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 31
      Top = 84
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 9
      Top = 107
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nosso Nro:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 18
      Top = 128
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblProtesta: TLabel
      Left = 18
      Top = 171
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Protesta:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 193
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Doc Antigo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodCliBai: TEdit
      Left = 65
      Top = 20
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 0
    end
    object edtNomCliBai: TEdit
      Left = 65
      Top = 41
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 1
    end
    object edtCodPorBai: TEdit
      Left = 65
      Top = 62
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 2
    end
    object edtNomPorBai: TEdit
      Left = 65
      Top = 83
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 3
    end
    object edtNosNum: TEdit
      Left = 65
      Top = 104
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 4
    end
    object edtHistor: TEdit
      Left = 65
      Top = 125
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 5
    end
    object edtHistor2: TEdit
      Left = 65
      Top = 146
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 6
    end
    object edtDesProtesta: TEdit
      Left = 65
      Top = 167
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 7
    end
    object edtCodVel: TEdit
      Left = 65
      Top = 188
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 8
    end
  end
  object pnlTotais: TPanel [3]
    Left = 0
    Top = 446
    Width = 937
    Height = 61
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label21: TLabel
      Left = 19
      Top = 14
      Width = 96
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total duplicatas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 12
      Top = 35
      Width = 103
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total Selecionado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDevol1: TLabel
      Left = 264
      Top = 14
      Width = 507
      Height = 14
      Caption = 
        'A coluna "Tem Devolu'#231#227'o" indica apenas que o documento teve algu' +
        'ma devolu'#231#227'o (TOTAL OU PARCIAL),'
    end
    object lblDevol2: TLabel
      Left = 264
      Top = 30
      Width = 348
      Height = 14
      Caption = 
        'sendo necess'#225'rio o usu'#225'rio validar se ir'#225' ou n'#227'o enviar como exc' +
        'lus'#227'o.'
    end
    object edtTotalDup: TEditFocus
      Left = 125
      Top = 13
      Width = 121
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtTotalSelecionado: TEditFocus
      Left = 125
      Top = 33
      Width = 121
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 22
    Width = 552
    Height = 424
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object dbgDuplicatas: TDBGridCitel
      Left = 0
      Top = 0
      Width = 552
      Height = 424
      Align = alClient
      FixedColor = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnCellClick = dbgDuplicatasCellClick
      OnDrawColumnCell = dbgDuplicatasDrawColumnCell
      OnDblClick = dbgDuplicatasDblClick
      OnKeyDown = dbgDuplicatasKeyDown
      OnKeyUp = dbgDuplicatasKeyUp
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CTR_CANCEL'
          Title.Caption = 'Cancelada'
          Width = 55
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTR_NUMDUP'
          Title.Alignment = taCenter
          Title.Caption = 'Duplicata'
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTR_ESPDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Esp'#233'cie'
          Width = 45
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTR_CODEMP'
          Title.Alignment = taCenter
          Title.Caption = 'Empresa'
          Width = 50
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTR_DTAVEN'
          Title.Alignment = taCenter
          Title.Caption = 'Vencimento'
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTR_DTAREC'
          Title.Alignment = taCenter
          Title.Caption = 'Recebimento'
          Width = 62
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTR_VALDUP'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor'
          Width = 58
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'DET_DEVOLV'
          Title.Alignment = taRightJustify
          Title.Caption = 'Tem Devolu'#231#227'o'
          Width = 81
          Visible = True
        end>
    end
  end
  object pnlTopo: TPanel [5]
    Left = 0
    Top = 0
    Width = 937
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Sele'#231#227'o de registros para o Serasa'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 17
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 64
  end
end
