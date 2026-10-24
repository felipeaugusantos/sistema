inherited frmCadMetas: TfrmCadMetas
  Left = 350
  Top = 119
  Width = 492
  Height = 530
  ActiveControl = mskDtaAtual
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Metas'
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 459
    Width = 484
    TabOrder = 2
    inherited btnSair: TBitBtn
      Left = 404
      TabOrder = 3
    end
    object btnConfirmar: TBitBtn
      Left = 3
      Top = 3
      Width = 105
      Height = 22
      Caption = '[ F10 ] Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnCopiarMetas: TBitBtn
      Left = 215
      Top = 3
      Width = 105
      Height = 22
      Caption = '[ F11 ] Copiar Metas'
      TabOrder = 2
      OnClick = btnCopiarMetasClick
    end
    object btnCancelar: TBitBtn
      Left = 109
      Top = 3
      Width = 105
      Height = 22
      Caption = '[ ESC ] Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 487
    Width = 484
    TabOrder = 3
    inherited pnlNomeForm: TPanel
      Left = 313
    end
    inherited pnlInfo: TPanel
      Width = 313
    end
  end
  object dbgMetas: TDBGridCitel [2]
    Left = 0
    Top = 35
    Width = 484
    Height = 424
    Align = alClient
    Ctl3D = True
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgMetasKeyDown
    OnKeyPress = dbgMetasKeyPress
  end
  object pnlMesAnoAtual: TPanel [3]
    Left = 0
    Top = 0
    Width = 484
    Height = 35
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = '   Periodo Atual de: '
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlMesAnoOrigem: TPanel
      Left = 270
      Top = 0
      Width = 214
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      object Label1: TLabel
        Left = 7
        Top = 11
        Width = 102
        Height = 14
        AutoSize = False
        Caption = 'Per'#237'odo de Origem:'
      end
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 1
        Height = 35
        Shape = bsLeftLine
      end
      object mskDtaOrigem: TMaskEditFocus
        Tag = 99
        Left = 103
        Top = 6
        Width = 100
        Height = 22
        EditMask = '99/9999'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        OnExit = mskDtaOrigemExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object mskDtaAtual: TMaskEditFocus
      Tag = 99
      Left = 109
      Top = 6
      Width = 94
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '  /    '
      OnExit = mskDtaAtualExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 8
  end
end
