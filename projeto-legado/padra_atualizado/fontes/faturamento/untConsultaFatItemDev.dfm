inherited frmConsultaFatItemDev: TfrmConsultaFatItemDev
  VertScrollBar.Range = 267
  Caption = 'Consulta de Itens Devolvidos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 250
  end
  inherited Panel1: TPanel
    inherited lblBuscarPor1: TLabel
      Left = 134
      ExplicitLeft = 134
    end
    inherited lblChave2: TLabel
      Top = 44
      ExplicitTop = 44
    end
    inherited lblBuscarPor2: TLabel
      Left = 134
      Top = 44
      ExplicitLeft = 134
      ExplicitTop = 44
    end
    inherited lblBuscarPor3: TLabel
      Left = 134
      ExplicitLeft = 134
    end
    inherited lstIndices: TListBox
      Width = 125
      Font.Charset = ANSI_CHARSET
      Font.Name = 'Arial'
      ItemHeight = 14
      ParentFont = False
      ExplicitWidth = 125
    end
    inherited edtFiltro1: TEdit
      Left = 134
      Font.Height = -11
      ExplicitLeft = 134
    end
    inherited edtFiltro2: TEdit
      Left = 134
      Font.Height = -11
      ExplicitLeft = 134
    end
    inherited edtFiltro3: TEdit
      Left = 134
      Width = 360
      Font.Height = -11
      ExplicitLeft = 134
      ExplicitWidth = 360
    end
    inherited chkConsContida: TCheckBox
      Left = 134
      ExplicitLeft = 134
    end
  end
  object pnlDadosItem: TPanel [4]
    Left = 0
    Top = 250
    Width = 780
    Height = 86
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object Label3: TLabel
      Left = 37
      Top = 13
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 56
      Top = 36
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unit'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 70
      Top = 59
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 354
      Top = 13
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 386
      Top = 36
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object dbeQtdIte: TDBEditFocus
      Left = 97
      Top = 9
      Width = 79
      Height = 22
      TabStop = False
      DataField = 'DET_QTDITE'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnitar: TDBEditFocus
      Left = 97
      Top = 32
      Width = 79
      Height = 22
      TabStop = False
      DataField = 'DET_UNITAR'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTotIte: TDBEditFocus
      Left = 97
      Top = 55
      Width = 79
      Height = 22
      TabStop = False
      DataField = 'DET_TOTITE'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodGru: TDBEditFocus
      Left = 423
      Top = 9
      Width = 78
      Height = 22
      TabStop = False
      DataField = 'Grupo'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Left = 423
      Top = 32
      Width = 78
      Height = 22
      TabStop = False
      DataField = 'C'#243'd. Item'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
end
