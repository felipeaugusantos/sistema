inherited frmFatVendaItem: TfrmFatVendaItem
  Width = 860
  Height = 360
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Complete as informa'#231#245'es do item'
  Position = poMainFormCenter
  ExplicitWidth = 860
  ExplicitHeight = 360
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 287
    Width = 854
    Visible = False
    ExplicitTop = 287
    ExplicitWidth = 854
    inherited FlwBotoes: TFlowPanel
      Width = 850
      ExplicitWidth = 850
    end
    inherited btnSair: TBitBtnLocked
      Left = 771
      ExplicitLeft = 771
    end
  end
  inherited pnlStatus: TPanel
    Top = 315
    Width = 854
    ExplicitTop = 315
    ExplicitWidth = 854
    inherited pnlNomeForm: TPanel
      Left = 683
      ExplicitLeft = 683
    end
    inherited pnlInfo: TPanel
      Width = 683
      Alignment = taLeftJustify
      Caption = 
        '  F7 - '#218'ltimas Vendas     F8 - Selecionar Lotes     F9 - Selecio' +
        'nar S'#233'ries'
      ExplicitWidth = 683
    end
  end
  object pnlImpostos: TPanel [2]
    Left = 0
    Top = 229
    Width = 854
    Height = 58
    Align = alBottom
    BevelWidth = 2
    Color = 16765627
    ParentBackground = False
    TabOrder = 2
    object Label15: TLabel
      Left = 164
      Top = 6
      Width = 97
      Height = 15
      Alignment = taCenter
      Caption = '   Dados Fiscais   '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 171
      Top = 22
      Width = 20
      Height = 14
      Alignment = taRightJustify
      Caption = 'CST'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 221
      Top = 22
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = 'CFOP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbCST: TLabel
      Left = 173
      Top = 37
      Width = 18
      Height = 14
      Alignment = taRightJustify
      Caption = '000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbCFOP: TLabel
      Left = 221
      Top = 37
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = '5.102'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 276
      Top = 6
      Width = 141
      Height = 15
      Alignment = taCenter
      Caption = '________ICMS________'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 296
      Top = 22
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 339
      Top = 22
      Width = 21
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'q.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbICMSbase: TLabel
      Left = 276
      Top = 37
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = '10000,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbICMSaliq: TLabel
      Left = 333
      Top = 37
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = '18,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 383
      Top = 22
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbICMSvalor: TLabel
      Left = 369
      Top = 37
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = '1000,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 431
      Top = 6
      Width = 133
      Height = 15
      Alignment = taCenter
      Caption = '________IPI_________'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 451
      Top = 22
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 494
      Top = 22
      Width = 21
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'q.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbIPIbase: TLabel
      Left = 431
      Top = 37
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = '10000,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbIPIaliq: TLabel
      Left = 488
      Top = 37
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = '18,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 538
      Top = 22
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbIPIvalor: TLabel
      Left = 524
      Top = 37
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = '1000,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 575
      Top = 6
      Width = 134
      Height = 15
      Alignment = taCenter
      Caption = '________ST_________'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 595
      Top = 22
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 642
      Top = 22
      Width = 17
      Height = 14
      Alignment = taRightJustify
      Caption = 'IVA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbSTbase: TLabel
      Left = 575
      Top = 37
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = '10000,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbSTiva: TLabel
      Left = 632
      Top = 37
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = '18,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 682
      Top = 22
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object llbSTvalor: TLabel
      Left = 668
      Top = 37
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = '1000,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label25: TLabel
      Left = 745
      Top = 6
      Width = 96
      Height = 15
      Alignment = taCenter
      Caption = 'Total c/ Impostos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object llbTotalimpostos: TLabel
      Left = 783
      Top = 29
      Width = 58
      Height = 19
      Alignment = taRightJustify
      Caption = '1000,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlUltimaCompra: TPanel
      Left = 5
      Top = 3
      Width = 141
      Height = 51
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label26: TLabel
        Left = 11
        Top = 3
        Width = 112
        Height = 15
        Alignment = taCenter
        Caption = '__'#218'ltima Compra__'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 31
        Top = 21
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object llbULtCompra: TLabel
        Left = 11
        Top = 34
        Width = 111
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '24/02/2017    20.6200'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 74
        Top = 21
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr.L'#237'quido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 854
    Height = 229
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
  end
  object tmrFechar: TTimer
    Enabled = False
    OnTimer = tmrFecharTimer
    Left = 664
    Top = 64
  end
end
