inherited frmCfgSpedFiscal: TfrmCfgSpedFiscal
  Width = 661
  Height = 709
  Caption = 'Configura'#231#245'es'
  OnDestroy = FormDestroy
  ExplicitWidth = 661
  ExplicitHeight = 671
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 598
    Width = 655
    ExplicitTop = 598
    ExplicitWidth = 655
    inherited FlwBotoes: TFlowPanel
      Width = 579
      ExplicitTop = 2
      ExplicitWidth = 579
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        Height = 24
        Visible = False
        ExplicitWidth = 74
        ExplicitHeight = 24
      end
      inherited btnGravar: TBitBtnLocked
        Tag = 18
        Left = 74
        Width = 74
        Height = 24
        Align = alLeft
        ExplicitLeft = 74
        ExplicitWidth = 74
        ExplicitHeight = 24
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        Height = 24
        Visible = False
        ExplicitLeft = 148
        ExplicitWidth = 74
        ExplicitHeight = 24
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        Height = 24
        Visible = False
        ExplicitLeft = 222
        ExplicitWidth = 74
        ExplicitHeight = 24
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        Height = 24
        Visible = False
        ExplicitLeft = 296
        ExplicitWidth = 74
        ExplicitHeight = 24
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        Height = 24
        Visible = False
        ExplicitLeft = 370
        ExplicitWidth = 74
        ExplicitHeight = 24
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 581
      Width = 72
      Height = 24
      Align = alRight
      ExplicitLeft = 581
      ExplicitWidth = 72
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 626
    Width = 655
    ExplicitTop = 626
    ExplicitWidth = 655
    inherited pnlNomeForm: TPanel
      Left = 454
      Width = 201
      ExplicitLeft = 454
      ExplicitWidth = 201
    end
    inherited pnlInfo: TPanel
      Width = 454
      ExplicitWidth = 454
    end
  end
  inherited pgcDados: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 649
    Height = 630
    ActivePage = tbsFiltros
    Style = tsButtons
    ExplicitLeft = 3
    ExplicitTop = 3
    ExplicitWidth = 649
    ExplicitHeight = 592
    object tbsFiltros: TTabSheet [0]
      Caption = 'Filtros'
      ImageIndex = 6
      object Label21: TLabel
        Left = 16
        Top = 13
        Width = 94
        Height = 14
        Caption = 'Perfil do Declarante'
      end
      object Label22: TLabel
        Left = 16
        Top = 41
        Width = 103
        Height = 14
        Caption = 'Finalidade do Arquivo'
      end
      object Label23: TLabel
        Left = 16
        Top = 69
        Width = 82
        Height = 14
        Caption = 'Tipo de Atividade'
      end
      object Label24: TLabel
        Left = 16
        Top = 97
        Width = 174
        Height = 14
        Caption = 'Classifica'#231#227'o de Contribuintes do IPI'
      end
      object Label25: TLabel
        Left = 16
        Top = 125
        Width = 160
        Height = 14
        Caption = 'Regime de Substitui'#231#227'o Tribut'#225'ria'
      end
      object Label26: TLabel
        Left = 16
        Top = 153
        Width = 203
        Height = 14
        Caption = 'Registro 0015 - Enviar IE na UF de Destino'
      end
      object cmbPERFIL_DECLARANTE: TComboBox
        Tag = 99
        Left = 233
        Top = 10
        Width = 242
        Height = 22
        Style = csDropDownList
        TabOrder = 0
        Items.Strings = (
          'A - A'
          'B - B'
          'C - C')
      end
      object cmbFINALIDADE_ARQUIVO: TComboBox
        Tag = 99
        Left = 233
        Top = 38
        Width = 242
        Height = 22
        Style = csDropDownList
        TabOrder = 1
        Items.Strings = (
          'O - Original'
          'S - Substituto')
      end
      object cmbREG0015_ENV_IE_UF_DEST: TComboBox
        Tag = 99
        Left = 233
        Top = 150
        Width = 242
        Height = 22
        Style = csDropDownList
        TabOrder = 5
        Items.Strings = (
          'S - Sim'
          'N - N'#227'o')
      end
      object cmbTIPO_ATIVIDADE: TComboBox
        Tag = 99
        Left = 233
        Top = 66
        Width = 242
        Height = 22
        Style = csDropDownList
        TabOrder = 2
        Items.Strings = (
          '0 - Industrial'
          '1 - N'#227'o Industrial')
      end
      object cmbCLASSIF_CONTRIB_IPI: TComboBox
        Tag = 99
        Left = 233
        Top = 94
        Width = 242
        Height = 22
        Style = csDropDownList
        TabOrder = 3
        Items.Strings = (
          '00 - Industrial Transforma'#231#227'o'
          '01 - Industrial Beneficiamento'
          '02 - Industrial Montagem'
          '03 - Industrial Acondicionamento ou Reacondicionamento'
          '04 - Industrial Renova'#231#227'o ou Recondicionamento'
          '05 - Equiparado a industrial Por op'#231#227'o'
          '06 - Equiparado a industrial Importa'#231#227'o Direta'
          '07 - Equiparado a industrial Por lei espec'#237'fica'
          
            '08 - Equiparado a industrial N'#227'o enquadrado nos c'#243'digos 05, 06 o' +
            'u 07'
          '09 - Outros')
      end
      object cmbREGIME_SUBST_TRIB: TComboBox
        Tag = 99
        Left = 233
        Top = 122
        Width = 242
        Height = 22
        Style = csDropDownList
        TabOrder = 4
        Items.Strings = (
          '2 - Substituto'
          '1 - Substitu'#237'do')
      end
    end
    inherited tbsGeral: TTabSheet
      Caption = 'Fiscal'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 641
      ExplicitHeight = 560
      object Label61: TLabel
        Left = 1
        Top = 2
        Width = 167
        Height = 14
        Caption = 'Fornecedor para ICMS antecipado:'
      end
      object Label209: TLabel
        Left = 366
        Top = 2
        Width = 224
        Height = 14
        Caption = 'CFOP com indicador de pagamento 2-OUTROS'
      end
      object Label29: TLabel
        Left = 264
        Top = 541
        Width = 282
        Height = 14
        Caption = 'Com Base de C'#225'lculo Zero e Valor Cont'#225'bil Maior que Zero'
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 1
        Top = 19
        Width = 63
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ReadOnly = True
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
      object edtNomFor: TEditFocus
        Tag = 99
        Left = 64
        Top = 19
        Width = 288
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
      object edtSpedCfopIndPag: TEditFocus
        Tag = 99
        Left = 366
        Top = 19
        Width = 263
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkEnvia0460icmstipi: TCheckBox
        Tag = 99
        Left = 1
        Top = 44
        Width = 254
        Height = 17
        Caption = 'Enviar Somente o Registro 0460 de ICMS-ST e IPI'
        TabOrder = 3
      end
      object chkRegE316Analitico: TCheckBox
        Tag = 99
        Left = 280
        Top = 44
        Width = 161
        Height = 17
        Caption = 'Enviar Registro E316 Anal'#237'tico'
        TabOrder = 4
      end
      object chkEnviarRegE316IESubstSpedFiscal: TCheckBox
        Tag = 99
        Left = 442
        Top = 44
        Width = 187
        Height = 17
        Caption = 'Enviar Registro E316 IE Subst. Trib.'
        TabOrder = 5
      end
      object chkAjuDet: TCheckBox
        Tag = 99
        Left = 1
        Top = 61
        Width = 200
        Height = 17
        Caption = 'Enviar Ajustes Detalhado por Produto'
        TabOrder = 6
      end
      object chkEnviaPrecoLiquidoH010: TCheckBox
        Tag = 99
        Left = 280
        Top = 61
        Width = 281
        Height = 17
        Caption = 'Enviar Pre'#231'o L'#237'quido Registro H010 Campo 11'
        TabOrder = 7
      end
      object chkEnviarNfSaidaRegE250: TCheckBox
        Tag = 99
        Left = 1
        Top = 78
        Width = 259
        Height = 17
        Caption = 'Enviar Notas Fiscais de Sa'#237'da Registro E250'
        TabOrder = 8
      end
      object chkEnviarDadosEmpresaAnteriorSpedFiscal: TCheckBox
        Tag = 99
        Left = 280
        Top = 78
        Width = 233
        Height = 17
        Caption = 'Enviar Dados Empresa Anterior'
        TabOrder = 9
      end
      object chkEnviarValDevDifal: TCheckBox
        Tag = 99
        Left = 1
        Top = 93
        Width = 259
        Height = 32
        Caption = 
          'Enviar Valores de Devolu'#231#227'o de Venda de DIFAL n'#227'o Contribuinte (' +
          'Valores da UF destino)'
        TabOrder = 11
        WordWrap = True
      end
      object chkEnviarCredIcmsCat158Sped: TCheckBox
        Tag = 99
        Left = 280
        Top = 96
        Width = 233
        Height = 17
        Caption = 'Enviar Cr'#233'dito de ICMS CAT-158'
        TabOrder = 12
      end
      object chkEnviarFixo1RegC100Campo13: TCheckBox
        Tag = 99
        Left = 280
        Top = 112
        Width = 207
        Height = 17
        Caption = 'Enviar Fixo "1" Registro C100 Campo 13'
        TabOrder = 13
      end
      object chkEnviarC195: TCheckBox
        Tag = 99
        Left = 1
        Top = 122
        Width = 120
        Height = 17
        Caption = 'Enviar Registro C195'
        Checked = True
        State = cbChecked
        TabOrder = 14
      end
      object chkEnviarH020Especial: TCheckBox
        Tag = 99
        Left = 280
        Top = 128
        Width = 207
        Height = 17
        Caption = 'Enviar H020 Especial'
        TabOrder = 15
      end
      object chkEnviaAjustesFECP: TCheckBox
        Tag = 99
        Left = 1
        Top = 139
        Width = 144
        Height = 17
        Caption = 'Enviar Ajustes do FECP'
        TabOrder = 16
      end
      object chkEnviarDesc0460_C195: TCheckBox
        Tag = 99
        Left = 280
        Top = 144
        Width = 349
        Height = 17
        Caption = 'Alterar Desc. do Reg. 0460/C195 qdo C'#243'digo de Ajuste XX23000999'
        TabOrder = 17
      end
      object chkUniCompraEntradaConvertida: TCheckBox
        Tag = 99
        Left = 1
        Top = 156
        Width = 278
        Height = 17
        Caption = 'Enviar Unidade de Compra para Entradas Convertidas'
        TabOrder = 18
      end
      object chkUniCompraEntradaFornecedor: TCheckBox
        Tag = 99
        Left = 280
        Top = 160
        Width = 288
        Height = 17
        Caption = 'Enviar Unidade de Compra para Entradas Fornecedor'
        TabOrder = 19
      end
      object rgTipExpE200: TRadioGroup
        Tag = 99
        Left = 2
        Top = 179
        Width = 158
        Height = 63
        Caption = 'Tipo da Exporta'#231#227'o Reg E200'
        ItemIndex = 0
        Items.Strings = (
          'GNRE'
          'GARE')
        TabOrder = 20
      end
      object rgInfoBlocoK: TRadioGroup
        Tag = 99
        Left = 166
        Top = 179
        Width = 315
        Height = 63
        Caption = 'Informa'#231#245'es Bloco K (Sped fiscal)'
        ItemIndex = 0
        Items.Strings = (
          'Sim'
          'N'#227'o'
          'Ind'#250'stria: N'#227'o enviar K230/K235')
        TabOrder = 21
      end
      object chkEnviarRegistrosK220: TCheckBox
        Tag = 99
        Left = 222
        Top = 193
        Width = 125
        Height = 17
        Caption = 'Enviar Registros K220'
        TabOrder = 22
      end
      object chkEnviarRegistros0210: TCheckBox
        Tag = 99
        Left = 222
        Top = 208
        Width = 125
        Height = 17
        Caption = 'Enviar Registros 0210'
        TabOrder = 23
      end
      object GroupBox47: TGroupBox
        Tag = 99
        Left = 487
        Top = 186
        Width = 143
        Height = 56
        TabOrder = 26
        object chkEnviarRegSomenteK200Sped: TCheckBox
          Tag = 99
          Left = 9
          Top = 6
          Width = 128
          Height = 17
          Caption = 'Somente registro K200'
          TabOrder = 0
        end
      end
      object grbInfoFECP: TGroupBox
        Tag = 99
        Left = 2
        Top = 243
        Width = 247
        Height = 44
        Caption = 'Informa'#231#245'es da FECP'
        TabOrder = 27
        object Label180: TLabel
          Left = 6
          Top = 21
          Width = 61
          Height = 14
          Caption = 'C'#243'd. Receita'
        end
        object edtCodRecFECP: TEditFocus
          Tag = 99
          Left = 73
          Top = 14
          Width = 159
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object grbInfoGare: TGroupBox
        Tag = 99
        Left = 255
        Top = 243
        Width = 248
        Height = 44
        Caption = 'Informa'#231#245'es da Gare'
        TabOrder = 28
        object Label87: TLabel
          Left = 6
          Top = 21
          Width = 61
          Height = 14
          Caption = 'C'#243'd. Receita'
        end
        object edtCodGare: TEditFocus
          Tag = 99
          Left = 73
          Top = 14
          Width = 159
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object grbInventario: TGroupBox
        Tag = 99
        Left = 2
        Top = 287
        Width = 628
        Height = 224
        Caption = 'Invent'#225'rio:'
        TabOrder = 29
        object Label202: TLabel
          Left = 9
          Top = 35
          Width = 111
          Height = 14
          Caption = 'Pre'#231'o campo06 (H010)'
        end
        object Label204: TLabel
          Left = 9
          Top = 59
          Width = 110
          Height = 14
          Caption = 'Pre'#231'o campo11 (H010)'
        end
        object Label211: TLabel
          Left = 399
          Top = 35
          Width = 91
          Height = 14
          Caption = 'Participante Broker'
        end
        object Label212: TLabel
          Left = 399
          Top = 59
          Width = 106
          Height = 14
          Caption = 'Conta Anal'#237'tica Broker'
        end
        object Label278: TLabel
          Left = 7
          Top = 176
          Width = 322
          Height = 14
          Caption = 'Empresa(s) '#225' Considerar no Somat'#243'rio dos Registros H010 e K200'
        end
        object cmbPrecoRegH010Campo06: TComboBox
          Tag = 99
          Left = 136
          Top = 32
          Width = 214
          Height = 22
          Style = csDropDownList
          TabOrder = 2
          Items.Strings = (
            'Pre'#231'o de Compra'
            'Pre'#231'o de Custo'
            'Pre'#231'o de Venda 1'
            'Pre'#231'o de Venda 2'
            'Pre'#231'o de Venda 3'
            'Pre'#231'o de Venda 4'
            'Pre'#231'o de Venda 5'
            'Pre'#231'o de Venda 6'
            'Pre'#231'o de Venda 7'
            'Pre'#231'o M'#233'dio de Compra'
            'Pre'#231'o '#250'ltima compra menos impostos federais'
            'Pre'#231'o de compra mais impostos'
            'Pre'#231'o de compra l'#237'quido')
        end
        object cmbPrecoRegH010Campo11: TComboBox
          Tag = 99
          Left = 136
          Top = 56
          Width = 248
          Height = 22
          Style = csDropDownList
          TabOrder = 3
          Items.Strings = (
            'Pre'#231'o de Compra'
            'Pre'#231'o de Custo'
            'Pre'#231'o de Venda 1'
            'Pre'#231'o de Venda 2'
            'Pre'#231'o de Venda 3'
            'Pre'#231'o de Venda 4'
            'Pre'#231'o de Venda 5'
            'Pre'#231'o de Venda 6'
            'Pre'#231'o de Venda 7'
            'Pre'#231'o M'#233'dio de Compra'
            'Pre'#231'o '#250'ltima compra menos impostos federais'
            'Pre'#231'o de compra mais impostos'
            'Pre'#231'o de compra l'#237'quido')
        end
        object chkUtilizarPrecoConfiguradoRegH010: TCheckBox
          Tag = 99
          Left = 9
          Top = 14
          Width = 171
          Height = 14
          Caption = 'Utilizar os pre'#231'os configurados'
          TabOrder = 0
        end
        object rgAlteracaoTributaria: TRadioGroup
          Tag = 99
          Left = 7
          Top = 112
          Width = 241
          Height = 62
          Caption = 'Altera'#231#227'o tribut'#225'ria de Produtos'
          ItemIndex = 0
          Items.Strings = (
            'Substitu'#237'dos para Produtos Tributados'
            'Tributados para Produtos Substitu'#237'dos')
          TabOrder = 9
        end
        object edtPartBrokerSped: TEditFocus
          Tag = 99
          Left = 520
          Top = 32
          Width = 98
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtContaAnaliticaBrokerSpedBlocoH: TEditFocus
          Tag = 99
          Left = 520
          Top = 56
          Width = 98
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEmpresasSelecionadas: TEditFocus
          Tag = 99
          Left = 7
          Top = 192
          Width = 482
          Height = 22
          Hint = 
            'A(s) Empresa(s) Selecionada(s) agregar'#227'o seus valores de Saldos ' +
            'e valores de Saldos ML nos somat'#243'rio dos registros H010 e K200 t' +
            'endo como base a Empresa Logada.'
          TabStop = False
          Alignment = taLeftJustify
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object gbUsarAliqInventOuAliqDigitada: TGroupBox
          Left = 254
          Top = 112
          Width = 364
          Height = 62
          Caption = 'Aliq. para o Cr'#233'dito'
          TabOrder = 10
          object Label279: TLabel
            Left = 8
            Top = 16
            Width = 50
            Height = 14
            Caption = 'Reg. H020'
          end
          object Label280: TLabel
            Left = 8
            Top = 29
            Width = 173
            Height = 14
            Caption = 'Aplicado apenas p/ Itens Tributados'
          end
          object Label281: TLabel
            Left = 64
            Top = 16
            Width = 180
            Height = 12
            AutoSize = False
            Caption = '- Moitvo: 04'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtAliqInventOuAliqDigitada: TEditFocus
            Tag = 99
            Left = 254
            Top = 17
            Width = 103
            Height = 22
            Alignment = taRightJustify
            TabOrder = 0
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object chkEnviarApenasOsItensTributados: TCheckBox
            Tag = 99
            Left = 8
            Top = 44
            Width = 349
            Height = 14
            Caption = 'Enviar Apenas os Itens Tributados'
            TabOrder = 1
          end
        end
        object chkUtilizaPartBrokerOuTerceiro: TCheckBox
          Tag = 99
          Left = 399
          Top = 14
          Width = 200
          Height = 14
          Caption = 'Utilizar Estoque Participante Terceiro'
          TabOrder = 1
        end
        object edtPartTerceiroSped: TEditFocus
          Tag = 99
          Left = 520
          Top = 32
          Width = 98
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 5
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtContaAnaliticaTerceiroSpedBlocoH: TEditFocus
          Tag = 99
          Left = 520
          Top = 56
          Width = 98
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 7
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnSelEmpresa: TBitBtnLocked
          Left = 491
          Top = 191
          Width = 127
          Height = 24
          Caption = 'Selecionar Empresas(s)'
          TabOrder = 12
          OnClick = btnSelEmpresaClick
        end
        object btnLinGruExcluir: TBitBtnLocked
          Left = 498
          Top = 84
          Width = 120
          Height = 24
          Caption = 'Linha/Grupo a Excluir'
          TabOrder = 8
          OnClick = btnLinGruExcluirClick
        end
      end
      object chkEnviarRegistrosK280: TCheckBox
        Tag = 99
        Left = 349
        Top = 193
        Width = 125
        Height = 17
        Caption = 'Enviar Registros K280'
        TabOrder = 24
      end
      object cmbPeriodoK280: TComboBox
        Tag = 99
        Left = 355
        Top = 212
        Width = 114
        Height = 22
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 25
        Text = 'Anual'
        Items.Strings = (
          'Anual'
          'Trimestral')
      end
      object chkEnviarPisCofins_: TCheckBox
        Tag = 99
        Left = 496
        Top = 78
        Width = 121
        Height = 17
        Caption = 'Enviar PIS e COFINS'
        TabOrder = 10
      end
      object chkENVIAR_C180_C185: TCheckBox
        Tag = 99
        Left = 1
        Top = 543
        Width = 248
        Height = 17
        Caption = 'Enviar o Registro C180/C185 no Sped Fiscal?'
        TabOrder = 30
      end
      object chkENVIANOTADEBITOCREDITODEVOLUCAO: TCheckBox
        Tag = 99
        Left = 1
        Top = 561
        Width = 248
        Height = 17
        Caption = 'Enviar Notas de Debito/Credito de Devolu'#231#245'es?'
        TabOrder = 31
      end
      object edtCST_BASE_ICMS_ZERADO_VLR_CONTABIL_MAIOR_ZERO_D190: TEditFocus
        Tag = 99
        Left = 264
        Top = 558
        Width = 356
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 32
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object tsSpedFiscal2: TTabSheet
      Caption = 'Fiscal - 2'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label247: TLabel
        Left = 3
        Top = 70
        Width = 146
        Height = 14
        Caption = 'CST de Servi'#231'o Registro C170'
      end
      object Label264: TLabel
        Left = 3
        Top = 91
        Width = 181
        Height = 14
        Caption = 'C'#243'digo do Ajuste E111 Transf. Cr'#233'dito'
      end
      object Label265: TLabel
        Left = 224
        Top = 91
        Width = 197
        Height = 14
        Caption = 'Descri'#231#227'o do Ajuste E111 Transf. Cr'#233'dito'
      end
      object Label266: TLabel
        Left = 3
        Top = 132
        Width = 177
        Height = 14
        Caption = 'C'#243'digo do Ajuste E111 Transf. D'#233'bito'
      end
      object Label267: TLabel
        Left = 224
        Top = 132
        Width = 193
        Height = 14
        Caption = 'Descri'#231#227'o do Ajuste E111 Transf. D'#233'bito'
      end
      object Label268: TLabel
        Left = 3
        Top = 173
        Width = 202
        Height = 14
        Caption = 'C'#243'digo do Ajuste E111 H020 Mudan'#231'a Trib'
      end
      object Label269: TLabel
        Left = 224
        Top = 173
        Width = 218
        Height = 14
        Caption = 'Descri'#231#227'o do Ajuste E111 H020 Mudan'#231'a Trib'
      end
      object Label248: TLabel
        Left = 3
        Top = 214
        Width = 208
        Height = 14
        Caption = 'C'#243'digo Receita E116 Diferencial de Al'#237'quota'
      end
      object chkEnviarFcpNfSpedFiscal: TCheckBox
        Tag = 99
        Left = 3
        Top = 0
        Width = 273
        Height = 17
        Caption = 'Enviar Fundo de Combate a Pobreza somado NF-e'
        TabOrder = 0
      end
      object chkRegraCat66ConsolidadoSpedfiscal: TCheckBox
        Tag = 99
        Left = 285
        Top = 0
        Width = 141
        Height = 17
        Caption = 'Regra Cat-66 Consolidado'
        TabOrder = 1
      end
      object chkRegraCat66Spedfiscal: TCheckBox
        Tag = 99
        Left = 444
        Top = 0
        Width = 93
        Height = 17
        Caption = 'Regra Cat-66'
        TabOrder = 2
      end
      object chkEnviarFcpNfceSpedFiscal: TCheckBox
        Tag = 99
        Left = 3
        Top = 16
        Width = 278
        Height = 17
        Caption = 'Enviar Fundo de Combate a Pobreza Somado NFC-e'
        TabOrder = 3
      end
      object chkRegraCat66ApenasCfop: TCheckBox
        Tag = 99
        Left = 285
        Top = 16
        Width = 333
        Height = 17
        Caption = 'Enviar Apenas o CFOP na Descri'#231#227'o do Ajuste da Regra Cat-66'
        TabOrder = 4
      end
      object chkEnviarVlrFcpCampo24C100_09C190: TCheckBox
        Tag = 99
        Left = 3
        Top = 32
        Width = 276
        Height = 17
        Caption = 'Enviar Val.FCP-ST nos campos ST, C100/C170/C190'
        TabOrder = 5
      end
      object chk54Detalhado: TCheckBox
        Tag = 99
        Left = 285
        Top = 32
        Width = 141
        Height = 17
        Caption = 'Regra Cat-54 Detalhado'
        TabOrder = 6
      end
      object chkFiscaisCat42: TCheckBox
        Tag = 99
        Left = 3
        Top = 48
        Width = 278
        Height = 17
        Caption = 'Enviar Fiscais Cat-42 (Registros E111/E112)'
        TabOrder = 7
      end
      object edtCstServicoSpedFiscal: TEditFocus
        Tag = 99
        Left = 162
        Top = 67
        Width = 105
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodAjuE111TransfCre: TEditFocus
        Tag = 99
        Left = 3
        Top = 108
        Width = 212
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesAjuE111TransfCre: TEditFocus
        Tag = 99
        Left = 224
        Top = 108
        Width = 312
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodAjuE111TransfDeb: TEditFocus
        Tag = 99
        Left = 3
        Top = 149
        Width = 212
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesAjuE111TransfDeb: TEditFocus
        Tag = 99
        Left = 224
        Top = 149
        Width = 312
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodAjuE111MudancaTribSpedFiscal: TEditFocus
        Tag = 99
        Left = 3
        Top = 190
        Width = 212
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesAjuE111MudancaTribSpedFiscal: TEditFocus
        Tag = 99
        Left = 224
        Top = 190
        Width = 312
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodAjuE116DifAliqSpedFiscal: TEditFocus
        Tag = 99
        Left = 3
        Top = 231
        Width = 212
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkEnviarCST090CT: TCheckBox
        Tag = 99
        Left = 3
        Top = 256
        Width = 264
        Height = 17
        Caption = 'Enviar CST 090 para Documentos com Esp'#233'cie CT'
        TabOrder = 18
      end
      object grpCstRegD190SpedFiscal: TGroupBox
        Tag = 99
        Left = 3
        Top = 275
        Width = 350
        Height = 112
        Caption = 'CST Transporte Registro D190'
        TabOrder = 20
        object Label273: TLabel
          Left = 9
          Top = 45
          Width = 268
          Height = 14
          Caption = 'Com ICMS e Base de C'#225'culo Menor que o Valor Cont'#225'bil'
        end
        object Label274: TLabel
          Left = 9
          Top = 66
          Width = 93
          Height = 14
          Caption = 'Base de ICMS Zero'
        end
        object Label275: TLabel
          Left = 9
          Top = 20
          Width = 247
          Height = 14
          Align = alCustom
          Caption = 'Com ICMS e Base de C'#225'lculo Igual ao Valor Cont'#225'bil'
        end
        object Label276: TLabel
          Left = 9
          Top = 89
          Width = 90
          Height = 14
          Caption = 'CTE Complementar'
        end
        object edtCstBaseIcmsMenorD190: TEditFocus
          Tag = 99
          Left = 286
          Top = 40
          Width = 53
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCstBaseIcmsZeradoD190: TEditFocus
          Tag = 99
          Left = 286
          Top = 63
          Width = 53
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCstBaseIcmsIgualD190: TEditFocus
          Tag = 99
          Left = 286
          Top = 17
          Width = 53
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCstCteComplementarD190: TEditFocus
          Tag = 99
          Left = 286
          Top = 86
          Width = 53
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object gpbEnviarContaContabil: TGroupBox
        Tag = 99
        Left = 359
        Top = 274
        Width = 268
        Height = 60
        Caption = 'Enviar Conta Anal'#237'tica Cont'#225'bil '
        TabOrder = 21
        object Label277: TLabel
          Left = 28
          Top = 36
          Width = 145
          Height = 14
          Align = alCustom
          Caption = 'Registros: C170, D100 e C500'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object chkUtilizarRotinaDeContabilidade: TCheckBox
          Tag = 99
          Left = 11
          Top = 18
          Width = 239
          Height = 17
          Align = alCustom
          Caption = 'Utilizar Rotina de Contabilidade'
          TabOrder = 0
        end
      end
      object chkEnviaCodFabricaNaDescricaoRegC170: TCheckBox
        Tag = 99
        Left = 285
        Top = 48
        Width = 289
        Height = 17
        Caption = 'Enviar Descri'#231#227'o de Compra dos Registros C170'
        TabOrder = 8
      end
      object gpbRegistro0205: TGroupBox
        Tag = 99
        Left = 3
        Top = 389
        Width = 208
        Height = 112
        Caption = 'Registro 0205'
        TabOrder = 22
        object Label1: TLabel
          Left = 15
          Top = 51
          Width = 51
          Height = 14
          Caption = 'Data Inicial'
        end
        object Label2: TLabel
          Left = 15
          Top = 79
          Width = 47
          Height = 14
          Caption = 'Data Final'
        end
        object chkEnvCodProd0205: TCheckBox
          Tag = 99
          Left = 15
          Top = 23
          Width = 183
          Height = 17
          Caption = 'Enviar c'#243'digo anterior do produto'
          TabOrder = 0
        end
        object mskDtIni0205: TMaskEditFocus
          Tag = 99
          Left = 72
          Top = 48
          Width = 62
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtFin0205: TMaskEditFocus
          Tag = 99
          Left = 72
          Top = 76
          Width = 64
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          TabOrder = 2
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
      end
      object gpbRegistro1400: TGroupBox
        Tag = 99
        Left = 217
        Top = 389
        Width = 410
        Height = 100
        Caption = 'Registro 1400'
        TabOrder = 23
        object Label3: TLabel
          Left = 15
          Top = 46
          Width = 286
          Height = 14
          Caption = 'C'#243'digo do item ('#205'ndice de Participa'#231#227'o dos Munic'#237'pios - IPM)'
        end
        object chkReg1400: TCheckBox
          Tag = 99
          Left = 15
          Top = 23
          Width = 183
          Height = 17
          Caption = 'Enviar Registro 1400'
          TabOrder = 0
        end
        object edtCodigoItemIPM: TEditFocus
          Tag = 99
          Left = 15
          Top = 62
          Width = 345
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 120
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbBlocoG: TGroupBox
        Tag = 99
        Left = 269
        Top = 215
        Width = 358
        Height = 58
        Caption = 'Bloco G'
        TabOrder = 19
        object chkIncluirCFOP5929_6959RegG110: TCheckBox
          Tag = 99
          Left = 16
          Top = 18
          Width = 320
          Height = 17
          Caption = 'Enviar CFOP 5929-6929 na parte das Sa'#237'das do Registro G110'
          TabOrder = 0
        end
        object chkG110TributContabil: TCheckBox
          Tag = 99
          Left = 16
          Top = 36
          Width = 339
          Height = 17
          Caption = 'Desconsiderar CFOP 5929-6929 no campo 06 do Registro G110'
          TabOrder = 1
        end
      end
      object gpbServicos: TGroupBox
        Tag = 99
        Left = 359
        Top = 340
        Width = 268
        Height = 47
        Caption = 'Servi'#231'os'
        TabOrder = 24
        object chkEntrarNotasMunicipaisServico: TCheckBox
          Tag = 99
          Left = 11
          Top = 19
          Width = 236
          Height = 17
          Caption = 'Enviar Notas Fiscais Municipais - 1933/2933'
          TabOrder = 0
        end
      end
      object chkEnvDescrC170UsoCon: TCheckBox
        Tag = 99
        Left = 285
        Top = 64
        Width = 339
        Height = 17
        Caption = 'Enviar Descri'#231#227'o dos Itens nos Documentos de Uso e Consumo'
        TabOrder = 9
      end
    end
    object tsSpedFiscal3: TTabSheet
      Caption = 'Fiscal - 3'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label7: TLabel
        Left = 10
        Top = 29
        Width = 356
        Height = 14
        Caption = 
          'CFOPs para cr'#233'dito presumido do regime especial E-Commerce do Pa' +
          'ran'#225
      end
      object Label8: TLabel
        Left = 10
        Top = 74
        Width = 414
        Height = 14
        Caption = 
          'C'#243'digo do ajuste usado no regime presumido do estado do Paran'#225' p' +
          'ara cr'#233'dito (E113)'
      end
      object Label12: TLabel
        Left = 10
        Top = 272
        Width = 565
        Height = 14
        Caption = 
          'Enviar informa'#231#227'o de valores no Campo Valor do Documento ou Valo' +
          'r da Mercadoria da CFOP 5929 no Registro C100'
      end
      object Label13: TLabel
        Left = 10
        Top = 320
        Width = 266
        Height = 14
        Caption = 'C'#243'digo da Receita para C'#243'd. do ICMS 090 do Reg. E116'
      end
      object chkENVIACREDITOPRESUMIDODOREGESPECOMMERCEPR: TCheckBox
        Tag = 99
        Left = 10
        Top = 6
        Width = 355
        Height = 17
        Caption = 'Envia cr'#233'dito presumido do regime especial E-Commerce do Paran'#225
        TabOrder = 0
      end
      object edtCFOPSPARACREDITOPRESUMIDODOREGESPECOMMERCEPR: TEditFocus
        Tag = 99
        Left = 10
        Top = 44
        Width = 415
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCOD_AJU_E113_PRESUM_PR_CRE: TEditFocus
        Tag = 99
        Left = 10
        Top = 89
        Width = 167
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rgInfoBlocoK010: TGroupBox
        Tag = 99
        Left = 10
        Top = 117
        Width = 415
        Height = 52
        Caption = 'Informa'#231#245'es Bloco K010 (Sped fiscal)'
        TabOrder = 3
        object Label9: TLabel
          Left = 16
          Top = 21
          Width = 133
          Height = 14
          Caption = 'Indicador de Tipo de Layout'
        end
        object cmbIndTipLayK010: TComboBox
          Tag = 99
          Left = 155
          Top = 19
          Width = 242
          Height = 22
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = '0 - Leiaute Simplificado'
          Items.Strings = (
            '0 - Leiaute Simplificado'
            '1 - Leiaute Completo'
            '2 - Leiaute Restrito aos Saldos de Estoque')
        end
      end
      object gbCFOPNaoGeraReceita: TGroupBox
        Tag = 99
        Left = 10
        Top = 176
        Width = 295
        Height = 86
        Caption = 'CFOPs que n'#227'o geram receita'
        TabOrder = 4
        object Label11: TLabel
          Left = 17
          Top = 24
          Width = 75
          Height = 14
          Caption = 'Informe o CFOP'
        end
        object edtCFOP: TEditFocus
          Tag = 99
          Left = 98
          Top = 19
          Width = 52
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 4
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 4
          TipoTexto = ttInteiro
        end
        object btnIncluiCFOP: TBitBtnLocked
          Left = 156
          Top = 19
          Width = 29
          Height = 22
          Caption = '+'
          TabOrder = 1
          OnClick = btnIncluiCFOPClick
        end
        object btnRemoveCFOP: TBitBtnLocked
          Left = 188
          Top = 19
          Width = 29
          Height = 22
          Caption = '-'
          TabOrder = 2
          OnClick = btnRemoveCFOPClick
        end
        object edtCFOPNaoGeraReceita: TEditFocus
          Left = 17
          Top = 47
          Width = 264
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object gbCFOP_Tratada_Como_Substituto: TGroupBox
        Tag = 99
        Left = 311
        Top = 176
        Width = 295
        Height = 86
        Caption = 'CFOPs tratadas como substituto'
        TabOrder = 5
        object Label10: TLabel
          Left = 17
          Top = 24
          Width = 75
          Height = 14
          Caption = 'Informe o CFOP'
        end
        object edtCFOPSubstituto: TEditFocus
          Tag = 99
          Left = 98
          Top = 19
          Width = 52
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 4
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 4
          TipoTexto = ttInteiro
        end
        object btnIncluiCFOPSubstituto: TBitBtnLocked
          Left = 156
          Top = 19
          Width = 29
          Height = 22
          Caption = '+'
          TabOrder = 1
          OnClick = btnIncluiCFOPSubstitutoClick
        end
        object btnRemoveCFOPSubstituto: TBitBtnLocked
          Left = 188
          Top = 19
          Width = 29
          Height = 22
          Caption = '-'
          TabOrder = 2
          OnClick = btnRemoveCFOPSubstitutoClick
        end
        object edtCFOP_Tratada_Como_Substituto: TEditFocus
          Left = 17
          Top = 47
          Width = 264
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object cmbENVIA_VLDOC_VLMERC_5929: TComboBox
        Tag = 99
        Left = 10
        Top = 292
        Width = 133
        Height = 22
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 6
        Text = 'Valor Documento'
        Items.Strings = (
          'Valor Documento'
          'Valor Mercadoria')
      end
      object edtCODIGO_RECEITA_090_E116: TEditFocus
        Tag = 99
        Left = 10
        Top = 340
        Width = 167
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gbCST_MONOFASICO_ICMS_ENTRADA: TGroupBox
        Tag = 99
        Left = 10
        Top = 369
        Width = 295
        Height = 86
        Caption = 'CST'#39's Monof'#225'sicas de ICMS na Entrada de Produtos'
        TabOrder = 8
        object Label14: TLabel
          Left = 17
          Top = 24
          Width = 68
          Height = 14
          Caption = 'Informe a CST'
        end
        object edtCST: TEditFocus
          Tag = 99
          Left = 98
          Top = 19
          Width = 52
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttInteiro
        end
        object btnIncluiCST: TBitBtnLocked
          Left = 156
          Top = 19
          Width = 29
          Height = 22
          Caption = '+'
          TabOrder = 1
          OnClick = btnIncluiCSTClick
        end
        object btnRemoveCST: TBitBtnLocked
          Left = 188
          Top = 19
          Width = 29
          Height = 22
          Caption = '-'
          TabOrder = 2
          OnClick = btnRemoveCSTClick
        end
        object edtCST_MONOFASICO_ICMS_ENTRADA: TEditFocus
          Left = 17
          Top = 47
          Width = 264
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object chkNAO_ENVIAR_E200_SE_VALORES_IGUAL0: TCheckBox
        Tag = 99
        Left = 10
        Top = 465
        Width = 355
        Height = 17
        Caption = 'N'#227'o Enviar o Registro E200/E210, quando valores igual zero. '
        TabOrder = 9
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Dados Recolhimento ICMS'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Tag = 99
        Left = 3
        Top = 3
        Width = 635
        Height = 117
        Caption = 'Recolhimento mensal de ICMS'
        TabOrder = 0
        object Label47: TLabel
          Left = 18
          Top = 21
          Width = 144
          Height = 14
          Caption = 'C'#243'd. Estadual (dentro estado)'
        end
        object Label48: TLabel
          Left = 175
          Top = 22
          Width = 105
          Height = 14
          Caption = 'Dia de Vencto. (ICMS)'
        end
        object Label4: TLabel
          Left = 295
          Top = 22
          Width = 94
          Height = 14
          Caption = 'Dia de Vencto. (ST)'
        end
        object lblCodEstadualDentroEstado: TLabel
          Left = 18
          Top = 61
          Width = 160
          Height = 14
          Hint = 
            'Para configurar os c'#243'digos de recolhimento de ST, por favor use ' +
            'o bot'#227'o ao lado.'
          Caption = 'C'#243'd. Estadual ST (dentro estado)'
          ParentShowHint = False
          ShowHint = True
        end
        object edtCodEstadRecolheIcms: TEditFocus
          Tag = 99
          Left = 18
          Top = 37
          Width = 109
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
        object edtDiaVencIcms: TMaskEditFocus
          Tag = 99
          Left = 175
          Top = 37
          Width = 88
          Height = 22
          EditMask = '99;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 1
          Text = '  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDiaVencIcmsST: TMaskEditFocus
          Tag = 99
          Left = 295
          Top = 37
          Width = 89
          Height = 22
          EditMask = '99;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 2
          Text = '  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtCodEstadRecolheIcmsSTDentroEstado: TEditFocus
          Tag = 99
          Left = 18
          Top = 77
          Width = 111
          Height = 22
          Hint = 
            'Para configurar os c'#243'digos de recolhimento de ST, por favor use ' +
            'o bot'#227'o ao lado.'
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
        object btnCodigosRecolhimentoST: TBitBtnLocked
          Tag = 99
          Left = 138
          Top = 77
          Width = 162
          Height = 22
          Caption = 'C'#243'digos de recolhimento de ST'
          TabOrder = 4
          OnClick = btnCodigosRecolhimentoSTClick
        end
      end
      object GroupBox2: TGroupBox
        Tag = 99
        Left = 3
        Top = 126
        Width = 635
        Height = 105
        Caption = 'Recolhimento mensal DIFAL'
        TabOrder = 1
        object Label140: TLabel
          Left = 18
          Top = 23
          Width = 105
          Height = 14
          Caption = 'Dia Vencimento DIFAL'
        end
        object edtDiaVencDifalDestino: TMaskEditFocus
          Tag = 99
          Left = 18
          Top = 40
          Width = 89
          Height = 22
          EditMask = '99;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 0
          Text = '  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object btnCodigosRecolhimentoDIFAL: TBitBtnLocked
          Tag = 99
          Left = 18
          Top = 67
          Width = 161
          Height = 22
          Caption = 'C'#243'digos de recolhimento Difal'
          TabOrder = 1
          OnClick = btnCodigosRecolhimentoDIFALClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'C'#243'digos de Ajustes'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        Tag = 99
        Left = 3
        Top = 3
        Width = 635
        Height = 118
        Caption = 'Ajustes E110'
        TabOrder = 0
        object Label176: TLabel
          Left = 20
          Top = 24
          Width = 127
          Height = 14
          Caption = 'C'#243'd. Aj. Icms Pr'#243'prio FECP'
        end
        object Label241: TLabel
          Left = 20
          Top = 67
          Width = 127
          Height = 14
          Caption = 'C'#243'd. Aj. Icms Pr'#243'prio FECP'
        end
        object Label177: TLabel
          Left = 180
          Top = 25
          Width = 253
          Height = 14
          Caption = 'Descri'#231#227'o Ajuste Icms Pr'#243'prio FECP E110 - Campo12'
        end
        object Label242: TLabel
          Left = 180
          Top = 68
          Width = 253
          Height = 14
          Caption = 'Descri'#231#227'o Ajuste Icms Pr'#243'prio FECP E110 - Campo15'
        end
        object edtCodAjIcmsProprioFECP: TEditFocus
          Tag = 99
          Left = 20
          Top = 42
          Width = 120
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodAjIcmsProprioFECP2: TEditFocus
          Tag = 99
          Left = 20
          Top = 85
          Width = 120
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescAjIcmsProprioFECP: TEditFocus
          Tag = 99
          Left = 180
          Top = 42
          Width = 312
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescAjIcmsProprioFECP2: TEditFocus
          Tag = 99
          Left = 180
          Top = 85
          Width = 312
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object GroupBox4: TGroupBox
        Tag = 99
        Left = 3
        Top = 127
        Width = 635
        Height = 202
        Caption = 'Sub-Apura'#231#227'o 19xx'
        TabOrder = 1
        object Label5: TLabel
          Left = 15
          Top = 49
          Width = 143
          Height = 14
          Caption = 'Descri'#231#227'o do campo 3 (1900)'
        end
        object Label6: TLabel
          Left = 15
          Top = 104
          Width = 346
          Height = 14
          Caption = 
            'C'#243'd. Receita ref. obriga'#231#227'o pr'#243'prio da UF, conforme legisla'#231#227'o e' +
            'stadual'
        end
        object chk19XXSubApuracaoICMS: TCheckBox
          Tag = 99
          Left = 15
          Top = 24
          Width = 170
          Height = 17
          Caption = 'Enviar Sub-Apura'#231#227'o (19xx)'
          TabOrder = 0
        end
        object edtDescr19XXSubApuracaoICMS: TEditFocus
          Tag = 99
          Left = 15
          Top = 69
          Width = 602
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 200
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSPED_COD_RECOLHE_ICMS_1926: TEditFocus
          Tag = 99
          Left = 15
          Top = 124
          Width = 159
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkENVIA1923SUB: TCheckBox
          Tag = 99
          Left = 15
          Top = 152
          Width = 394
          Height = 17
          Caption = 'Enviar informa'#231#245'es adicionais (1923) Sub-apura'#231#227'o'
          TabOrder = 3
        end
        object chkSubApuCorrImporta: TCheckBox
          Tag = 99
          Left = 15
          Top = 175
          Width = 530
          Height = 17
          Caption = 
            '(1921 / 1923) Considerar al'#237'quota de cr'#233'dito presumido Ret. (Cor' +
            'redor de importa'#231#227'o)'
          TabOrder = 4
        end
      end
      object GroupBox5: TGroupBox
        Tag = 99
        Left = 3
        Top = 335
        Width = 635
        Height = 202
        Caption = 'CIAP'
        TabOrder = 2
        object chkG_DTAAQU_MES: TCheckBox
          Tag = 99
          Left = 15
          Top = 112
          Width = 394
          Height = 17
          Caption = 'Considerar o valor do G - CIAP dentro do m'#234's de aquisi'#231#227'o'
          TabOrder = 1
        end
        object GroupBox6: TGroupBox
          Tag = 99
          Left = 15
          Top = 20
          Width = 414
          Height = 86
          Caption = 
            'Lista de CFOPs que s'#227'o consideradas isentas para o relat'#243'rio CIA' +
            'P Modelo C'
          TabOrder = 0
          object Label15: TLabel
            Left = 17
            Top = 24
            Width = 75
            Height = 14
            Caption = 'Informe o CFOP'
          end
          object edtCFOPCIAP: TEditFocus
            Tag = 99
            Left = 98
            Top = 19
            Width = 52
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 4
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 4
            TipoTexto = ttInteiro
          end
          object btnIncluiCFOPCIAP: TBitBtnLocked
            Left = 156
            Top = 19
            Width = 29
            Height = 22
            Caption = '+'
            TabOrder = 1
            OnClick = btnIncluiCFOPCIAPClick
          end
          object btnRemoveCFOPCIAP: TBitBtnLocked
            Left = 188
            Top = 19
            Width = 29
            Height = 22
            Caption = '-'
            TabOrder = 2
            OnClick = btnRemoveCFOPCIAPClick
          end
          object edtCFOP_ISENTAS_CIAP_MODELO_C: TEditFocus
            Left = 17
            Top = 47
            Width = 380
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object chkENVIAR_VALOR_DIFAL_CIAP: TCheckBox
          Tag = 99
          Left = 15
          Top = 135
          Width = 394
          Height = 17
          Caption = 'Envia Diferencial de Al'#237'quota + Valor de ICMS no CIAP?'
          TabOrder = 2
        end
        object chkENVIAR_X929_SAIDA_CIAP: TCheckBox
          Tag = 99
          Left = 15
          Top = 158
          Width = 394
          Height = 17
          Caption = 'Envia CFOP X929 na sa'#237'da do CIAP?'
          TabOrder = 3
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Valida'#231#245'es'
      ImageIndex = 5
      object chkVALIDAR_CODIGO_RECEITA_REG_E: TCheckBox
        Tag = 99
        Left = 10
        Top = 6
        Width = 355
        Height = 17
        Caption = 'Validar c'#243'digo de receita dos registros E116, E250 e E316'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 536
    Top = 0
  end
  object dtsSpedConfEfd: TDataSource
    Left = 575
    Top = 2
  end
end
