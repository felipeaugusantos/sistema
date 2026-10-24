inherited frmGeraArqSerasaPEFINSel: TfrmGeraArqSerasaPEFINSel
  Left = 232
  Top = 250
  Width = 882
  Height = 494
  BorderStyle = bsNone
  Caption = 'frmGeraArqSerasaPEFINSel'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 882
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 452
    Width = 882
    Height = 26
    TabOrder = 1
    ExplicitTop = 452
    ExplicitWidth = 882
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 742
      Height = 22
      ExplicitWidth = 742
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
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 120
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F4 ] Desmarcar Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnDesmarcaTodosClick
      end
      object btnBusca: TBitBtnLocked
        Left = 240
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
        TabOrder = 2
        OnClick = btnBuscaClick
        OnKeyUp = btnOrdemKeyUp
      end
      object btnProximo: TBitBtnLocked
        Left = 360
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
        TabOrder = 3
        OnClick = btnProximoClick
        OnKeyUp = btnOrdemKeyUp
      end
      object btnSelTodos: TBitBtnLocked
        Left = 480
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F7 ] Seleciona Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnSelTodosClick
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
      Left = 744
      Top = 2
      Width = 136
      Align = alRight
      Caption = '[ESC] Sair'
      OnKeyUp = btnOrdemKeyUp
      ExplicitLeft = 744
      ExplicitTop = 2
      ExplicitWidth = 136
    end
  end
  inherited pnlStatus: TPanel
    Top = 478
    Width = 882
    TabOrder = 2
    ExplicitTop = 478
    ExplicitWidth = 882
    inherited pnlNomeForm: TPanel
      Left = 711
      ExplicitLeft = 711
    end
    inherited pnlInfo: TPanel
      Width = 711
      ExplicitWidth = 711
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 882
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Gera'#231#227'o de Arquivo para Serasa PEFIN'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 17
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
  end
  object pnlDadosDup: TPanel [3]
    Left = 472
    Top = 22
    Width = 410
    Height = 369
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object lblCliente: TLabel
      Left = 24
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
      Left = 29
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
      Left = 15
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
      Left = 29
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
      Left = 7
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
      Left = 16
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
      Left = 16
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
      Left = 5
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
      Left = 63
      Top = 20
      Width = 330
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 0
    end
    object edtNomCliBai: TEdit
      Left = 63
      Top = 41
      Width = 330
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 1
    end
    object edtCodPorBai: TEdit
      Left = 63
      Top = 62
      Width = 330
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 2
    end
    object edtNomPorBai: TEdit
      Left = 63
      Top = 83
      Width = 330
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 3
    end
    object edtNosNum: TEdit
      Left = 63
      Top = 104
      Width = 330
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 4
    end
    object edtHistor: TEdit
      Left = 63
      Top = 125
      Width = 330
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 5
    end
    object edtHistor2: TEdit
      Left = 63
      Top = 146
      Width = 330
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 6
    end
    object edtDesProtesta: TEdit
      Left = 63
      Top = 167
      Width = 330
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 7
    end
    object edtCodVel: TEdit
      Left = 63
      Top = 188
      Width = 330
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 8
    end
  end
  object pnlTotais: TPanel [4]
    Left = 0
    Top = 391
    Width = 882
    Height = 61
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
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
  object Panel1: TPanel [5]
    Left = 0
    Top = 22
    Width = 472
    Height = 369
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object dbgDuplicatas: TDBGridCitel
      Left = 0
      Top = 0
      Width = 472
      Height = 369
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
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTR_NUMDUP'
          Title.Alignment = taCenter
          Title.Caption = 'Duplicata'
          Width = 162
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTR_ESPDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Esp'#233'cie'
          Width = 44
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTR_CODEMP'
          Title.Alignment = taCenter
          Title.Caption = 'Empresa'
          Width = 57
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTR_DTAVEN'
          Title.Alignment = taCenter
          Title.Caption = 'Vencimento'
          Width = 71
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTR_VALDUP'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor'
          Width = 82
          Visible = True
        end>
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 64
  end
end
