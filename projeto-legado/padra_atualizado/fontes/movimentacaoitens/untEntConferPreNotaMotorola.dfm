inherited frmEntConferPreNotaMotorola: TfrmEntConferPreNotaMotorola
  Left = 195
  Top = 179
  Width = 332
  Height = 280
  BorderStyle = bsDialog
  Caption = 'Confer'#234'ncia de Entrada de Mercadorias (Pr'#233'-Nota)'
  OnClose = FormClose
  ExplicitWidth = 332
  ExplicitHeight = 280
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 187
    Width = 326
    Height = 48
    ExplicitTop = 187
    ExplicitWidth = 336
    ExplicitHeight = 48
    DesignSize = (
      326
      48)
    inherited FlwBotoes: TFlowPanel
      Width = 322
      Height = 44
      ExplicitTop = 2
      ExplicitWidth = 318
      ExplicitHeight = 40
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 38
        ExplicitWidth = 38
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 38
        Width = 39
        ExplicitLeft = 38
        ExplicitWidth = 39
      end
      object btnConfirma: TBitBtnLocked
        Left = 77
        Top = 0
        Width = 81
        Height = 22
        Caption = '[F10] Finaliza'
        Enabled = False
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnQuantidade: TBitBtnLocked
        Left = 158
        Top = 0
        Width = 91
        Height = 22
        Caption = '[F6] Quantidade'
        Enabled = False
        TabOrder = 3
        OnClick = btnQuantidadeClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 249
        Top = 0
        Width = 71
        Height = 22
        Caption = '&Excluir Item'
        Enabled = False
        TabOrder = 4
        OnClick = btnExcluirClick
      end
      object btnCriticas: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 70
        Height = 22
        Caption = '[F9] Cr'#237'ticas'
        Enabled = False
        TabOrder = 5
        OnClick = btnCriticasClick
      end
      object btnExcluirItensIncons: TBitBtnLocked
        Left = 70
        Top = 22
        Width = 179
        Height = 22
        Caption = '&Excluir itens com inconsist'#234'ncias'
        Enabled = False
        TabOrder = 6
        WordWrap = True
        OnClick = btnExcluirItensInconsClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 252
      Top = 24
      Width = 70
      Caption = '&Sair'
      Glyph.Data = {00000000}
      ExplicitLeft = 252
      ExplicitTop = 24
      ExplicitWidth = 70
    end
  end
  inherited pnlHeader: TPanel
    Width = 326
    Height = 77
    ExplicitWidth = 322
    ExplicitHeight = 77
    object pnlDigitador: TPanel
      Left = 0
      Top = 0
      Width = 326
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 322
      object lbl3: TLabel
        Left = 36
        Top = 11
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Digitador:'
      end
      object edtSenDig: TEditFocus
        Tag = 99
        Left = 84
        Top = 3
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomDig: TEditFocus
        Left = 142
        Top = 3
        Width = 163
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlItens: TPanel
      Left = 0
      Top = 51
      Width = 326
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Enabled = False
      TabOrder = 1
      ExplicitWidth = 322
      object Label2: TLabel
        Left = 144
        Top = 10
        Width = 40
        Height = 14
        Caption = 'Produto:'
      end
      object Label3: TLabel
        Left = 23
        Top = 10
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 186
        Top = 2
        Width = 119
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdIte: TEditFocus
        Tag = 99
        Left = 84
        Top = 2
        Width = 43
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 1
        Text = '1,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlNfe: TPanel
      Left = 0
      Top = 26
      Width = 326
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Enabled = False
      TabOrder = 2
      ExplicitWidth = 322
      object lblNotEle: TLabel
        Left = 6
        Top = 10
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nota Eletr'#244'nica:'
      end
      object btnNotEle: TBitBtnLocked
        Left = 84
        Top = 2
        Width = 41
        Height = 22
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
          300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
          330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
          333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
          339977FF777777773377000BFB03333333337773FF733333333F333000333333
          3300333777333333337733333333333333003333333333333377333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnNotEleClick
        OnEnter = btnNotEleEnter
      end
      object edtNotEle: TEditFocus
        Left = 125
        Top = 2
        Width = 180
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited pnlTail: TPanel
    Top = 181
    Width = 326
    Height = 6
    Enabled = False
    Visible = True
    ExplicitTop = 185
    ExplicitWidth = 322
    ExplicitHeight = 6
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 94
    Width = 326
    Height = 87
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quant.'
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESUNI'
        Title.Caption = 'Unid.'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        Title.Caption = 'C'#243'digo de F'#225'brica'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 144
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 77
    Width = 326
    Height = 17
    ExplicitTop = 77
    ExplicitWidth = 322
    ExplicitHeight = 17
  end
  inherited pnlStatus: TPanel
    Top = 235
    Width = 326
    ExplicitTop = 235
    ExplicitWidth = 322
    inherited pnlNomeForm: TPanel
      Left = 155
      ExplicitLeft = 151
    end
    inherited pnlInfo: TPanel
      Width = 155
      ExplicitWidth = 151
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 192
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 40
    Top = 112
  end
  inherited qryConsulta: TUniQuery
    Left = 136
    Top = 112
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 168
    Top = 112
  end
  inherited cdsConsulta: TUniClientDataSet
    DisableStringTrim = True
    AfterClose = cdsConsultaAfterClose
    Left = 200
    Top = 112
  end
  inherited dtsConsulta: TDataSource
    Left = 232
    Top = 112
  end
  object cdsCriticas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 144
    object cdsCriticasCODITE: TStringField
      FieldName = 'CODITE'
      Size = 30
    end
    object cdsCriticasDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsCriticasSIGUNI: TStringField
      FieldName = 'DESUNI'
      Size = 5
    end
    object cdsCriticasQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsCriticasQTDCON: TFloatField
      FieldName = 'QTDCON'
    end
    object cdsCriticasCODFAB: TStringField
      FieldName = 'CODFAB'
    end
    object cdsCriticasLOCFIS: TStringField
      FieldName = 'LOCFIS'
    end
    object cdsCriticasSALDOS: TFloatField
      FieldName = 'SALDOS'
    end
    object cdsCriticasQTDXML: TFloatField
      FieldName = 'QTDXML'
    end
  end
end
