inherited frmDigDesfazerBaixaPedNaoEntregues: TfrmDigDesfazerBaixaPedNaoEntregues
  Width = 446
  Height = 147
  Caption = 'Desfazer baixa de pedidos n'#227'o entregues'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 446
  ExplicitHeight = 147
  PixelsPerInch = 96
  TextHeight = 14
  object lblPedido: TLabel [0]
    Left = 37
    Top = 40
    Width = 32
    Height = 14
    Caption = 'Pedido'
  end
  object Label1: TLabel [1]
    Left = 27
    Top = 16
    Width = 42
    Height = 14
    Caption = 'Empresa'
  end
  inherited pnlBotoes: TPanel
    Top = 74
    Width = 440
    TabOrder = 3
    ExplicitTop = 74
    ExplicitWidth = 440
    inherited FlwBotoes: TFlowPanel
      Width = 436
      ExplicitWidth = 436
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 360
      ExplicitLeft = 360
    end
  end
  inherited pnlStatus: TPanel
    Top = 102
    Width = 440
    TabOrder = 4
    ExplicitTop = 102
    ExplicitWidth = 440
    inherited pnlNomeForm: TPanel
      Left = 269
      ExplicitLeft = 269
    end
    inherited pnlInfo: TPanel
      Width = 269
      ExplicitWidth = 269
    end
  end
  object edtNumPed: TEditFocus [4]
    Tag = 99
    Left = 75
    Top = 37
    Width = 92
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 12
    NumbersOnly = True
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 12
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [5]
    Left = 123
    Top = 13
    Width = 255
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 2
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodEmp: TEditFocus [6]
    Tag = 99
    Left = 75
    Top = 13
    Width = 46
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentFont = False
    TabOrder = 0
    OnExit = edtCodEmpExit
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 32
  end
end
