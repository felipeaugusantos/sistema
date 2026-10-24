inherited frmConsultaFatNovosItens: TfrmConsultaFatNovosItens
  Left = 233
  Top = 257
  VertScrollBar.Range = 219
  Caption = 'Consulta de Itens'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 298
  end
  inherited Panel1: TPanel
    inherited lblBuscarPor1: TLabel
      Left = 134
      ExplicitLeft = 134
    end
    inherited lblBuscarPor2: TLabel
      Left = 134
      ExplicitLeft = 134
    end
    inherited lblBuscarPor3: TLabel
      Left = 134
      ExplicitLeft = 134
    end
    inherited lstIndices: TListBox
      Width = 125
      ExplicitWidth = 125
    end
    inherited edtFiltro1: TEdit
      Left = 134
      Width = 374
      ExplicitLeft = 134
      ExplicitWidth = 374
    end
    inherited edtFiltro2: TEdit
      Left = 134
      Width = 374
      ExplicitLeft = 134
      ExplicitWidth = 374
    end
    inherited edtFiltro3: TEdit
      Left = 134
      Width = 374
      ExplicitLeft = 134
      ExplicitWidth = 374
    end
    inherited chkConsContida: TCheckBox
      Left = 134
      ExplicitLeft = 134
    end
  end
  object pnlDadosItem: TPanel [4]
    Left = 0
    Top = 298
    Width = 780
    Height = 38
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object Label3: TLabel
      Left = 47
      Top = 12
      Width = 80
      Height = 14
      Caption = 'Pre'#231'o de Venda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 313
      Top = 12
      Width = 30
      Height = 14
      Caption = 'Saldo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object dbePreVen: TDBEditFocus
      Left = 134
      Top = 8
      Width = 68
      Height = 22
      DataField = 'ITE_PREVE1'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSaldos: TDBEditFocus
      Left = 349
      Top = 8
      Width = 68
      Height = 22
      DataField = 'ITE_SALDOS'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
end
