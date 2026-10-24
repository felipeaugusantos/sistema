inherited frmPainelAcompanhamentoOS: TfrmPainelAcompanhamentoOS
  Width = 1366
  Height = 768
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Painel de Acompanhamento Geral de OS'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1366
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1360
    Visible = False
    ExplicitTop = 695
    ExplicitWidth = 1360
    inherited FlwBotoes: TFlowPanel
      Width = 1356
      ExplicitWidth = 1356
    end
    inherited btnSair: TBitBtnLocked
      Left = 1277
      ExplicitLeft = 1277
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1360
    ExplicitTop = 723
    ExplicitWidth = 1360
    inherited pnlNomeForm: TPanel
      Left = 1189
      ExplicitLeft = 1189
    end
    inherited pnlInfo: TPanel
      Width = 1189
      ExplicitWidth = 1189
    end
  end
  object grpPainel: TGridPanel [2]
    Left = 0
    Top = 57
    Width = 1360
    Height = 638
    Align = alClient
    BevelOuter = bvSpace
    ColumnCollection = <
      item
        Value = 25.758059343883910000
      end
      item
        Value = 25.328759214557810000
      end
      item
        Value = 24.791891946536850000
      end
      item
        Value = 24.121289495021430000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = pnlQuadro1
        Row = 0
      end
      item
        Column = 1
        Control = pnlQuadro2
        Row = 0
      end
      item
        Column = 2
        Control = pnlQuadro3
        Row = 0
      end
      item
        Column = 3
        Control = pnlQuadro4
        Row = 0
      end
      item
        Column = 0
        Control = pnlQuadro5
        Row = 1
      end
      item
        Column = 1
        Control = pnlQuadro6
        Row = 1
      end
      item
        Column = 2
        Control = pnlQuadro7
        Row = 1
      end
      item
        Column = 3
        Control = pnlQuadro8
        Row = 1
      end>
    ParentBackground = False
    ParentColor = True
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 2
    object pnlQuadro1: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 343
      Height = 312
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvSpace
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      Visible = False
      OnResize = pnlQuadro1Resize
      object pnlDescr1: TPanel
        Left = 2
        Top = 2
        Width = 339
        Height = 124
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 40
        Font.Name = 'Calibri'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lblDescr1: TLabel
          Left = 0
          Top = 0
          Width = 339
          Height = 124
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'DESCRI01'
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowFrame
          Font.Height = 70
          Font.Name = 'Calibri'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 427
          ExplicitHeight = 140
        end
      end
      object pnlQtde01: TPanel
        Left = 2
        Top = 126
        Width = 339
        Height = 184
        Align = alClient
        BevelOuter = bvNone
        Caption = '001'
        Ctl3D = True
        DockSite = True
        DoubleBuffered = False
        Font.Charset = ANSI_CHARSET
        Font.Color = 7815938
        Font.Height = 150
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentCtl3D = False
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
      end
    end
    object pnlQuadro2: TPanel
      AlignWithMargins = True
      Left = 353
      Top = 4
      Width = 337
      Height = 312
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvSpace
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      Visible = False
      OnResize = pnlQuadro2Resize
      object pnlDescr2: TPanel
        Left = 2
        Top = 2
        Width = 333
        Height = 124
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 30
        Font.Name = 'Calibri'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lblDescr2: TLabel
          Left = 0
          Top = 0
          Width = 333
          Height = 124
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'DESCRI02'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowFrame
          Font.Height = 70
          Font.Name = 'Calibri'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 2
          ExplicitTop = 2
          ExplicitWidth = 669
          ExplicitHeight = 78
        end
      end
      object pnlQtde02: TPanel
        Left = 2
        Top = 126
        Width = 333
        Height = 184
        Align = alClient
        BevelOuter = bvNone
        Caption = '002'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7815938
        Font.Height = 150
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
      end
    end
    object pnlQuadro3: TPanel
      AlignWithMargins = True
      Left = 696
      Top = 4
      Width = 330
      Height = 312
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvSpace
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      Visible = False
      OnResize = pnlQuadro3Resize
      object pnlDescr3: TPanel
        Left = 2
        Top = 2
        Width = 326
        Height = 124
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 30
        Font.Name = 'Calibri'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lblDescr3: TLabel
          Left = 0
          Top = 0
          Width = 326
          Height = 124
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'DESCRI03'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowFrame
          Font.Height = 70
          Font.Name = 'Calibri'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 2
          ExplicitTop = -2
          ExplicitWidth = 669
          ExplicitHeight = 80
        end
      end
      object pnlQtde03: TPanel
        Left = 2
        Top = 126
        Width = 326
        Height = 184
        Align = alClient
        BevelOuter = bvNone
        Caption = '003'
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = 7815938
        Font.Height = 150
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
      end
    end
    object pnlQuadro4: TPanel
      AlignWithMargins = True
      Left = 1032
      Top = 4
      Width = 324
      Height = 312
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvSpace
      ParentBackground = False
      ParentColor = True
      TabOrder = 3
      Visible = False
      OnResize = pnlQuadro4Resize
      object pnlDescr4: TPanel
        Left = 2
        Top = 2
        Width = 320
        Height = 124
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 30
        Font.Name = 'Calibri'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lblDescr4: TLabel
          Left = 0
          Top = 0
          Width = 320
          Height = 124
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'DESCRI04'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowFrame
          Font.Height = 70
          Font.Name = 'Calibri'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 2
          ExplicitTop = 2
          ExplicitWidth = 669
          ExplicitHeight = 78
        end
      end
      object pnlQtde04: TPanel
        Left = 2
        Top = 126
        Width = 320
        Height = 184
        Align = alClient
        BevelOuter = bvNone
        Caption = '004'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7815938
        Font.Height = 150
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
      end
    end
    object pnlQuadro5: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 322
      Width = 343
      Height = 312
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvSpace
      ParentBackground = False
      ParentColor = True
      TabOrder = 4
      Visible = False
      OnResize = pnlQuadro5Resize
      object pnlDescr5: TPanel
        Left = 2
        Top = 2
        Width = 339
        Height = 124
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 30
        Font.Name = 'Calibri'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lblDescr5: TLabel
          Left = 0
          Top = 0
          Width = 339
          Height = 124
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'DESCRI05'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowFrame
          Font.Height = 70
          Font.Name = 'Calibri'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 2
          ExplicitTop = 2
          ExplicitWidth = 669
          ExplicitHeight = 78
        end
      end
      object pnlQtde05: TPanel
        Left = 2
        Top = 126
        Width = 339
        Height = 184
        Align = alClient
        BevelOuter = bvNone
        Caption = '005'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7815938
        Font.Height = 150
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
      end
    end
    object pnlQuadro6: TPanel
      AlignWithMargins = True
      Left = 353
      Top = 322
      Width = 337
      Height = 312
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvSpace
      ParentBackground = False
      ParentColor = True
      TabOrder = 5
      Visible = False
      OnResize = pnlQuadro6Resize
      object pnlDescr6: TPanel
        Left = 2
        Top = 2
        Width = 333
        Height = 124
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 30
        Font.Name = 'Calibri'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lblDescr6: TLabel
          Left = 0
          Top = 0
          Width = 333
          Height = 124
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'DESCRI06'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowFrame
          Font.Height = 70
          Font.Name = 'Calibri'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 2
          ExplicitTop = 2
          ExplicitWidth = 669
          ExplicitHeight = 78
        end
      end
      object pnlQtde06: TPanel
        Left = 2
        Top = 126
        Width = 333
        Height = 184
        Align = alClient
        BevelOuter = bvNone
        Caption = '006'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7815938
        Font.Height = 150
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
      end
    end
    object pnlQuadro7: TPanel
      AlignWithMargins = True
      Left = 696
      Top = 322
      Width = 330
      Height = 312
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvSpace
      ParentBackground = False
      ParentColor = True
      TabOrder = 6
      Visible = False
      OnResize = pnlQuadro7Resize
      object pnlDescr7: TPanel
        Left = 2
        Top = 2
        Width = 326
        Height = 124
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 30
        Font.Name = 'Calibri'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lblDescr7: TLabel
          Left = 0
          Top = 0
          Width = 326
          Height = 124
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'DESCRI07'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowFrame
          Font.Height = 70
          Font.Name = 'Calibri'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 2
          ExplicitTop = 2
          ExplicitWidth = 669
          ExplicitHeight = 78
        end
      end
      object pnlQtde07: TPanel
        Left = 2
        Top = 126
        Width = 326
        Height = 184
        Align = alClient
        BevelOuter = bvNone
        Caption = '007'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7815938
        Font.Height = 150
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
      end
    end
    object pnlQuadro8: TPanel
      AlignWithMargins = True
      Left = 1032
      Top = 322
      Width = 324
      Height = 312
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvSpace
      ParentBackground = False
      ParentColor = True
      TabOrder = 7
      Visible = False
      OnResize = pnlQuadro8Resize
      object pnlDescr8: TPanel
        Left = 2
        Top = 2
        Width = 320
        Height = 124
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 30
        Font.Name = 'Calibri'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lblDescr8: TLabel
          Left = 0
          Top = 0
          Width = 320
          Height = 124
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'DESCRI08'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowFrame
          Font.Height = 70
          Font.Name = 'Calibri'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 2
          ExplicitTop = 2
          ExplicitWidth = 669
          ExplicitHeight = 78
        end
      end
      object pnlQtde08: TPanel
        Left = 2
        Top = 126
        Width = 320
        Height = 184
        Align = alClient
        BevelOuter = bvNone
        Caption = '008'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7815938
        Font.Height = 150
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
      end
    end
  end
  object pnlTopo: TPanel [3]
    Left = 0
    Top = 0
    Width = 1360
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowFrame
    Font.Height = 50
    Font.Name = 'Calibri'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    object lblTopo: TLabel
      Left = 1
      Top = 1
      Width = 1358
      Height = 55
      Align = alClient
      Alignment = taCenter
      Caption = 'ORDENS DE SERVI'#199'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowFrame
      Font.Height = 50
      Font.Name = 'Calibri'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 353
      ExplicitHeight = 50
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 288
    Top = 32
  end
  object tmrAtuPnl: TTimer
    Enabled = False
    OnTimer = tmrAtuPnlTimer
    Left = 480
    Top = 32
  end
end
