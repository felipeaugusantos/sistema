inherited frmEntMercadoriasEfetivaMovFiscal: TfrmEntMercadoriasEfetivaMovFiscal
  Width = 1024
  Height = 768
  Caption = 'Entrada de Mercadorias - Efetivar Movimento Fiscal'
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 685
    Width = 1008
    TabOrder = 2
    ExplicitTop = 685
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 120
        ExplicitWidth = 120
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 120
        Width = 120
        ExplicitLeft = 120
        ExplicitWidth = 120
      end
      object btnConfirma: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 120
        Height = 22
        Caption = '&Confirma'
        Enabled = False
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
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      ExplicitLeft = 929
    end
  end
  inherited pnlStatus: TPanel
    Top = 713
    Width = 1008
    TabOrder = 3
    ExplicitTop = 713
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  inherited pnlHeader: TPanel
    Width = 1008
    Height = 67
    TabOrder = 0
    ExplicitWidth = 1008
    ExplicitHeight = 67
    object Label1: TLabel
      Left = 41
      Top = 12
      Width = 58
      Height = 14
      AutoSize = False
      Caption = 'Fornecedor:'
    end
    object Label2: TLabel
      Left = 21
      Top = 36
      Width = 78
      Height = 14
      Caption = 'Transportadora:'
    end
    object edtNomFor: TEditFocus
      Left = 170
      Top = 8
      Width = 411
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 103
      Top = 8
      Width = 66
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodTra: TEditFocus
      Tag = 99
      Left = 103
      Top = 32
      Width = 66
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 1
      OnExit = edtCodTraExit
      OnKeyPress = edtCodTraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomTra: TEditFocus
      Left = 170
      Top = 32
      Width = 411
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 637
    Width = 1008
    TabOrder = 4
    ExplicitTop = 637
    ExplicitWidth = 1008
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 107
    Width = 1008
    Height = 530
    TabStop = False
    TabOrder = 1
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_SERIE_'
        Title.Caption = 'S'#233'rie'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODFOR'
        Title.Caption = 'C'#243'd. For.'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_NOMFOR'
        Title.Caption = 'Fornecedor'
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_DTADOC'
        Title.Caption = 'Data Doc.'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_TOTPRO'
        Title.Caption = 'Total Produtos'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_VLRCON'
        Title.Caption = 'Total do Doc.'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODTRA'
        Title.Caption = 'Cod. Transp.'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRA_NOMTRA'
        Title.Caption = 'Transportadora'
        Width = 176
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EFETIVADA'
        Title.Caption = 'Efetivada'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_OPECON'
        Title.Caption = 'Operador conferente'
        Width = 111
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_DTACON'
        Title.Caption = 'Data confer'#234'ncia'
        Width = 93
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 67
    Width = 1008
    ExplicitTop = 67
    ExplicitWidth = 1008
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 360
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 296
  end
  inherited qryConsulta: TUniQuery
    Left = 112
    Top = 360
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 144
    Top = 360
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 176
    Top = 360
  end
  inherited dtsConsulta: TDataSource
    Left = 224
    Top = 368
  end
end
