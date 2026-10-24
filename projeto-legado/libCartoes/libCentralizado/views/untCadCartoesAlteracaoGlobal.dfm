inherited frmCadCartoesAlteracaoGlobal: TfrmCadCartoesAlteracaoGlobal
  Width = 1024
  Height = 600
  BorderIcons = []
  Caption = 'Altera'#231#227'o global de cart'#245'es '
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 533
    Width = 1018
    Height = 22
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 533
    ExplicitWidth = 1018
    ExplicitHeight = 22
    inherited FlwBotoes: TFlowPanel
      Left = 0
      Top = 0
      Width = 935
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 935
      inherited btnConfirma: TBitBtnLocked
        AlignWithMargins = True
        Left = 3
        Width = 105
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '[ F10 ] Confirmar'
        Glyph.Data = {00000000}
        ModalResult = 0
        ExplicitLeft = 3
        ExplicitWidth = 105
      end
      object btnMarcarTodas: TBitBtnLocked
        AlignWithMargins = True
        Left = 108
        Top = 0
        Width = 105
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 1
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        AlignWithMargins = True
        Left = 213
        Top = 0
        Width = 125
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 2
        OnClick = btnDesmarcarTodasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 938
      Top = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alRight
      ExplicitLeft = 938
      ExplicitTop = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1018
    TabOrder = 3
    ExplicitTop = 555
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 839
      Width = 179
      ExplicitLeft = 839
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 839
      ExplicitWidth = 839
      object shpMultSel: TShape
        Left = 821
        Top = 2
        Width = 16
        Height = 12
        Hint = 'Cart'#245'es selecionados para serem alterados.'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 310
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  object PgcDados: TPageControl [2]
    Left = 0
    Top = 0
    Width = 570
    Height = 533
    ActivePage = TsBaixaOtimizadaPorEmpresa
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object tsBaixaOtimizada: TTabSheet
      Caption = '&1 - Informa'#231#245'es para Baixa Otimizada de Cart'#245'es'
      ImageIndex = 1
      object gbCredito: TGroupBox
        Left = 0
        Top = 0
        Width = 562
        Height = 176
        Align = alTop
        Caption = 'Cr'#233'dito/Taxa'
        TabOrder = 0
        object lblPORBAI: TLabel
          Left = 90
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
        end
        object lblCTABAI: TLabel
          Left = 53
          Top = 38
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Baixa:'
        end
        object lblEVECRE: TLabel
          Left = 47
          Top = 61
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Baixa:'
        end
        object lblPORTAX: TLabel
          Left = 49
          Top = 84
          Width = 130
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Taxa da Baixa:'
        end
        object lblFORTAX: TLabel
          Left = 34
          Top = 106
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor da Taxa da Baixa:'
        end
        object lblCTATAX: TLabel
          Left = 12
          Top = 130
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Taxa da Baixa:'
        end
        object lblEVETAX: TLabel
          Left = 6
          Top = 153
          Width = 173
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Taxa da Baixa:'
        end
        object edtPORBAI: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtPORBAIExit
          OnKeyPress = edtPORBAIKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtCTABAI: TEditFocus
          Left = 182
          Top = 35
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 2
          OnExit = edtCTABAIExit
          OnKeyPress = edtCTABAIKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtEVECRE: TEditFocus
          Left = 182
          Top = 58
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          NumbersOnly = True
          TabOrder = 4
          OnKeyPress = edtEVECREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttNumerico
        end
        object edtPORTAX: TEditFocus
          Left = 182
          Top = 81
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          NumbersOnly = True
          TabOrder = 6
          OnExit = edtPORTAXExit
          OnKeyPress = edtPORTAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtFORTAX: TEditFocus
          Left = 182
          Top = 104
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          NumbersOnly = True
          TabOrder = 8
          OnKeyPress = edtFORTAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtCTATAX: TEditFocus
          Left = 182
          Top = 127
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 10
          OnExit = edtCTATAXExit
          OnKeyPress = edtCTATAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtEVETAX: TEditFocus
          Left = 182
          Top = 150
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          NumbersOnly = True
          TabOrder = 12
          OnKeyPress = edtEVETAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttNumerico
        end
        object edtPORBAINome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
        object edtCTABAINome: TEditFocus
          Left = 247
          Top = 35
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEVECRENome: TEditFocus
          Left = 247
          Top = 58
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPORTAXNome: TEditFocus
          Left = 247
          Top = 81
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtFORTAXNome: TEditFocus
          Left = 247
          Top = 104
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCTATAXNome: TEditFocus
          Left = 247
          Top = 127
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 11
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEVETAXNome: TEditFocus
          Left = 247
          Top = 150
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 13
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object gbDebito: TGroupBox
        Left = 0
        Top = 176
        Width = 562
        Height = 84
        Align = alTop
        Caption = 'D'#233'bito'
        TabOrder = 1
        object lblEVEDEB: TLabel
          Left = 47
          Top = 61
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Baixa:'
        end
        object lblCTABAD: TLabel
          Left = 53
          Top = 38
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Baixa:'
        end
        object lblPORBAD: TLabel
          Left = 90
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
        end
        object edtEVEDEB: TEditFocus
          Left = 182
          Top = 58
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          NumbersOnly = True
          TabOrder = 4
          OnKeyPress = edtEVEDEBKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttNumerico
        end
        object edtCTABAD: TEditFocus
          Left = 182
          Top = 35
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 2
          OnExit = edtCTABADExit
          OnKeyPress = edtCTABADKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtPORBAD: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtPORBADExit
          OnKeyPress = edtPORBADKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtEVEDEBNome: TEditFocus
          Left = 247
          Top = 58
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCTABADNome: TEditFocus
          Left = 247
          Top = 35
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPORBADNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbCancelamentos: TGroupBox
        Left = 0
        Top = 260
        Width = 562
        Height = 38
        Align = alTop
        Caption = 'Cancelamentos/Ajustes'
        TabOrder = 2
        object lblCTAAJU: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtCTAAJU: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtCTAAJUExit
          OnKeyPress = edtCTAAJUKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtCTAAJUNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbAntecipacoes: TGroupBox
        Left = 0
        Top = 298
        Width = 562
        Height = 38
        Align = alTop
        Caption = 'Antecipa'#231#245'es'
        TabOrder = 3
        object lblCTAANT: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtCTAANT: TEditFocus
          Left = 181
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtCTAANTExit
          OnKeyPress = edtCTAANTKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtCTAANTNome: TEditFocus
          Left = 246
          Top = 12
          Width = 300
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
      object gbFretes: TGroupBox
        Left = 0
        Top = 336
        Width = 562
        Height = 38
        Align = alTop
        Caption = 'Fretes'
        TabOrder = 4
        object lblCTAFRE: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtCTAFRE: TEditFocus
          Left = 181
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtCTAFREExit
          OnKeyPress = edtCTAFREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtCTAFRENome: TEditFocus
          Left = 246
          Top = 12
          Width = 300
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
      object gbCupons: TGroupBox
        Left = 0
        Top = 374
        Width = 562
        Height = 38
        Align = alTop
        Caption = 'Cupons'
        TabOrder = 5
        object lblCTACUP: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtCTACUP: TEditFocus
          Left = 181
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtCTACUPExit
          OnKeyPress = edtCTACUPKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtCTACUPNome: TEditFocus
          Left = 246
          Top = 12
          Width = 300
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
      object grpExportacaoEquals: TGroupBox
        Left = 0
        Top = 412
        Width = 562
        Height = 64
        Align = alTop
        Caption = 'Exporta'#231#227'o Equals'
        TabOrder = 6
        object lblEQUADQ: TLabel
          Left = 118
          Top = 15
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Adquirinte:'
          WordWrap = True
        end
        object lblEQUCAP: TLabel
          Left = 97
          Top = 38
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Meio de Captura:'
        end
        object cmbEQUADQ: TDBLookupComboBox
          Tag = 99
          Left = 181
          Top = 11
          Width = 365
          Height = 22
          DataField = 'CAR_EQUADQ'
          KeyField = 'CODIGO'
          ListField = 'CODIGO;NOME'
          ListFieldIndex = 1
          TabOrder = 0
        end
        object cmbEQUCAP: TDBLookupComboBox
          Tag = 99
          Left = 181
          Top = 34
          Width = 365
          Height = 22
          DataField = 'CAR_EQUCAP'
          KeyField = 'CODIGO'
          ListField = 'CODIGO;NOME'
          ListFieldIndex = 1
          TabOrder = 1
        end
      end
    end
    object TsBaixaOtimizadaPorEmpresa: TTabSheet
      Caption = '&2 - Baixa Otimizada por Empresa (Concilia'#231#227'o)'
      object gbPorEmpresaCredito: TGroupBox
        Left = 0
        Top = 22
        Width = 562
        Height = 176
        Align = alTop
        Caption = 'Cr'#233'dito/Taxa'
        TabOrder = 1
        object lblPorEmpresaPORBAI: TLabel
          Left = 90
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
        end
        object lblPorEmpresaCTABAI: TLabel
          Left = 53
          Top = 38
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Baixa:'
        end
        object lblPorEmpresaEVECRE: TLabel
          Left = 47
          Top = 61
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Baixa:'
        end
        object lblPorEmpresaPORTAX: TLabel
          Left = 49
          Top = 84
          Width = 130
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Taxa da Baixa:'
        end
        object lblPorEmpresaFORTAX: TLabel
          Left = 34
          Top = 106
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor da Taxa da Baixa:'
        end
        object lblPorEmpresaCTATAX: TLabel
          Left = 12
          Top = 130
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Taxa da Baixa:'
        end
        object lblPorEmpresaEVETAX: TLabel
          Left = 6
          Top = 153
          Width = 173
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Taxa da Baixa:'
        end
        object edtPorEmpresaPORCRE: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaPORCREExit
          OnKeyPress = edtPorEmpresaPORCREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTACRE: TEditFocus
          Left = 182
          Top = 35
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnExit = edtPorEmpresaCTACREExit
          OnKeyPress = edtPorEmpresaCTACREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaEVECRE: TEditFocus
          Left = 182
          Top = 58
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          OnExit = edtPorEmpresaEVECREExit
          OnKeyPress = edtPorEmpresaEVECREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaPORTAX: TEditFocus
          Left = 182
          Top = 81
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          OnExit = edtPorEmpresaPORTAXExit
          OnKeyPress = edtPorEmpresaPORTAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaFORTAX: TEditFocus
          Left = 182
          Top = 104
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          OnExit = edtPorEmpresaFORTAXExit
          OnKeyPress = edtPorEmpresaFORTAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTATAX: TEditFocus
          Left = 182
          Top = 127
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          OnExit = edtPorEmpresaCTATAXExit
          OnKeyPress = edtPorEmpresaCTATAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaEVETAX: TEditFocus
          Left = 182
          Top = 150
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          OnExit = edtPorEmpresaEVETAXExit
          OnKeyPress = edtPorEmpresaEVETAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaPORCRENome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
        object edtPorEmpresaCTACRENome: TEditFocus
          Left = 247
          Top = 35
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaEVECRENome: TEditFocus
          Left = 247
          Top = 58
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaPORTAXNome: TEditFocus
          Left = 247
          Top = 81
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaFORTAXNome: TEditFocus
          Left = 247
          Top = 104
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTATAXNome: TEditFocus
          Left = 247
          Top = 127
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 11
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaEVETAXNome: TEditFocus
          Left = 247
          Top = 150
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 13
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object gbPorEmpresaDebito: TGroupBox
        Left = 0
        Top = 198
        Width = 562
        Height = 84
        Align = alTop
        Caption = 'D'#233'bito'
        TabOrder = 2
        object lblPorEmpresaEVEDEB: TLabel
          Left = 47
          Top = 61
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Baixa:'
        end
        object lblPorEmpresaCTABAD: TLabel
          Left = 53
          Top = 38
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Baixa:'
        end
        object lblPorEmpresaPORBAD: TLabel
          Left = 90
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
        end
        object edtPorEmpresaEVEDEB: TEditFocus
          Left = 182
          Top = 58
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          OnExit = edtPorEmpresaEVEDEBExit
          OnKeyPress = edtPorEmpresaEVEDEBKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTADEB: TEditFocus
          Left = 182
          Top = 35
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnExit = edtPorEmpresaCTADEBExit
          OnKeyPress = edtPorEmpresaCTADEBKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaPORDEB: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaPORDEBExit
          OnKeyPress = edtPorEmpresaPORDEBKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaEVEDEBNome: TEditFocus
          Left = 247
          Top = 58
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTADEBNome: TEditFocus
          Left = 247
          Top = 35
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaPORDEBNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbPorEmpresaCancelamentos: TGroupBox
        Left = 0
        Top = 282
        Width = 562
        Height = 38
        Align = alTop
        Caption = 'Cancelamentos/Ajustes'
        TabOrder = 3
        object lblPorEmpresaCTAAJU: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtPorEmpresaCTAAJU: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCTAAJUExit
          OnKeyPress = edtPorEmpresaCTAAJUKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTAAJUNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbPorEmpresaAntecipacoes: TGroupBox
        Left = 0
        Top = 320
        Width = 562
        Height = 38
        Align = alTop
        Caption = 'Antecipa'#231#245'es'
        TabOrder = 4
        object lblPorEmpresaCTAANT: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtPorEmpresaCTAANT: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCTAANTExit
          OnKeyPress = edtPorEmpresaCTAANTKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTAANTNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbPorEmpresaFretes: TGroupBox
        Left = 0
        Top = 358
        Width = 562
        Height = 38
        Align = alTop
        Caption = 'Fretes'
        TabOrder = 5
        object lblPorEmpresaCTAFRE: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtPorEmpresaCTAFRE: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCTAFREExit
          OnKeyPress = edtPorEmpresaCTAFREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTAFRENome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbPorEmpresaCupons: TGroupBox
        Left = 0
        Top = 396
        Width = 562
        Height = 38
        Align = alTop
        Caption = 'Cupons'
        TabOrder = 6
        object lblPorEmpresaCTACUP: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtPorEmpresaCTACUP: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCTACUPExit
          OnKeyPress = edtPorEmpresaCTACUPKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTACUPNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object pnlPorEmpresaCODEMP: TPanel
        Left = 0
        Top = 0
        Width = 562
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lblPorEmpresaCODEMP: TLabel
          Left = 134
          Top = 3
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object edtPorEmpresaCODEMPNome: TEditFocus
          Left = 247
          Top = 0
          Width = 300
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
        object edtPorEmpresaCODEMP: TEditFocus
          Left = 182
          Top = 0
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCODEMPExit
          OnKeyPress = edtPorEmpresaCODEMPKeyPress
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
  end
  object GridCartoes: TcxGrid [3]
    AlignWithMargins = True
    Left = 573
    Top = 0
    Width = 442
    Height = 532
    Margins.Top = 0
    Margins.Bottom = 1
    Align = alRight
    TabOrder = 1
    object TableViewCartoes: TcxGridDBTableView
      OnDblClick = TableViewCartoesDblClick
      OnKeyDown = TableViewCartoesKeyDown
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.FocusViewOnApplyFilter = True
      FindPanel.InfoText = 'Digite para pesquisar'
      FindPanel.ShowClearButton = False
      FindPanel.ShowFindButton = False
      OnCustomDrawCell = TableViewCartoesCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' cart'#245'es cadastrados'
      OptionsView.GroupByBox = False
      Styles.ContentOdd = styleZebraOdd
      object TableViewCartoesMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        VisibleForCustomization = False
        VisibleForEditForm = bFalse
      end
      object TableViewCartoesCODCAR: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CAR_CODCAR'
        Width = 45
      end
      object TableViewCartoesDESCAR: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'CAR_DESCAR'
        Width = 190
      end
      object TableViewCartoesEMPRESA: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMPRESA'
        Width = 185
      end
    end
    object GridCartoesLevel: TcxGridLevel
      GridView = TableViewCartoes
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 152
  end
  object dtsCartoes: TDataSource
    AutoEdit = False
    Left = 492
    Top = 212
  end
  object styleGridCartoes: TcxStyleRepository
    Left = 492
    Top = 266
    PixelsPerInch = 96
    object styleZebraOdd: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
