object fraOpcPdfPedidoCompra: TfraOpcPdfPedidoCompra
  Tag = 99
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 5
  Padding.Top = 5
  Padding.Right = 10
  Padding.Bottom = 5
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object pnltContainer: TPanel
    Left = 5
    Top = 5
    Width = 436
    Height = 295
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object gbExporta: TGroupBox
      Left = 0
      Top = 0
      Width = 436
      Height = 45
      Align = alTop
      Caption = 'Exportar'
      TabOrder = 0
      object ColorLabel1: TColorLabel
        Left = 29
        Top = 20
        Width = 66
        Height = 13
        Caption = '(P)df   (E)xcel'
        CorDestaque = clRed
      end
      object edtTipExp: TEditFocus
        Tag = 99
        Left = 8
        Top = 16
        Width = 18
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'P'
        OnChange = edtTipExpChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object btnOpcoesExcel: TBitBtnLocked
        Left = 110
        Top = 17
        Width = 32
        Height = 20
        Caption = '[+]'
        TabOrder = 1
        Visible = False
        OnClick = btnOpcoesExcelClick
      end
    end
    object pnlEmail: TPanel
      Left = 0
      Top = 70
      Width = 436
      Height = 47
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Label1: TLabel
        Left = 24
        Top = 4
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'E-mail:'
      end
      object Label2: TLabel
        Left = 13
        Top = 27
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Contato:'
      end
      object edtEmail: TEditFocus
        Tag = 99
        Left = 59
        Top = 1
        Width = 371
        Height = 21
        Alignment = taLeftJustify
        MaxLength = 80
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtContato: TEditFocus
        Tag = 99
        Left = 59
        Top = 24
        Width = 371
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 50
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
    object grbImprimirDados: TGroupBox
      Left = 0
      Top = 117
      Width = 436
      Height = 155
      Align = alTop
      Caption = 'Imprimir:'
      TabOrder = 2
      object chkMarca: TCheckBox
        Left = 9
        Top = 18
        Width = 97
        Height = 17
        Caption = 'Imprimir Marca'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object chkCodFab: TCheckBox
        Left = 9
        Top = 50
        Width = 157
        Height = 17
        Caption = 'Imprimir C'#243'digo de F'#225'brica'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object chkImpObs: TCheckBox
        Left = 9
        Top = 66
        Width = 157
        Height = 17
        Caption = 'Imprimir Observa'#231#245'es'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object chkLocFis: TCheckBox
        Left = 9
        Top = 34
        Width = 164
        Height = 17
        Caption = 'Imprimir Localiza'#231#227'o Fisica'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object chkCodbarras: TCheckBox
        Left = 9
        Top = 82
        Width = 157
        Height = 17
        Caption = 'Imprimir C'#243'digo de Barras'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object ChkImpReferencia: TCheckBox
        Left = 9
        Top = 98
        Width = 157
        Height = 17
        Caption = 'Imprimir Referencia'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object chkPreco: TCheckBox
        Left = 9
        Top = 114
        Width = 157
        Height = 17
        Caption = 'Imprimir Pre'#231'o'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object chkMltCmp: TCheckBox
        Left = 10
        Top = 130
        Width = 271
        Height = 17
        Caption = 'Gerar quantidade convertida em m'#250'ltiplos de compra'
        TabOrder = 7
        OnClick = chkMltCmpClick
      end
      object pnlResumo: TPanel
        Left = 191
        Top = 42
        Width = 242
        Height = 79
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 9
        object chkResumoMarca: TCheckBox
          Left = 2
          Top = -1
          Width = 225
          Height = 17
          Caption = 'Imprimir Resumo de Litros/Kilos por Marca'
          TabOrder = 0
        end
        object chkResumoReferencia: TCheckBox
          Left = 2
          Top = 15
          Width = 225
          Height = 17
          Caption = 'Imprimir Resumo por Refer'#234'ncia'
          TabOrder = 1
        end
        object chkResumoGrupo: TCheckBox
          Left = 2
          Top = 47
          Width = 225
          Height = 17
          Caption = 'Imprimir Resumo de Litros/Kilos por Grupo'
          TabOrder = 2
        end
        object chkResumoUnidade: TCheckBox
          Left = 2
          Top = 31
          Width = 225
          Height = 17
          Caption = 'Imprimir Resumo por Unidade'
          TabOrder = 3
        end
        object chkResumoAcordoObjetivo: TCheckBox
          Left = 2
          Top = 62
          Width = 225
          Height = 17
          Caption = 'Imprimir Resumo por Acordo de Objetivo'
          TabOrder = 4
        end
      end
      object chkImpVen: TCheckBox
        Left = 193
        Top = 16
        Width = 225
        Height = 26
        Caption = 
          'Imprimir o pedido de compra com as Datas de Vencimento dos Pagam' +
          'entos?'
        TabOrder = 8
        WordWrap = True
      end
    end
    object rdgQuantidade: TRadioGroup
      Left = 0
      Top = 272
      Width = 436
      Height = 35
      Align = alTop
      Caption = 'Quantidade'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Total'
        'Pendente'
        'N'#227'o exibir')
      TabOrder = 3
    end
    object gbOrdem: TRadioGroup
      Left = 0
      Top = 307
      Width = 436
      Height = 35
      Align = alTop
      Caption = 'Ordem'
      Columns = 3
      Items.Strings = (
        'Digita'#231#227'o'
        'Alfab'#233'tica'
        'C'#243'd. F'#225'brica')
      TabOrder = 4
    end
    object rdgOrientacao: TRadioGroup
      Left = 0
      Top = 342
      Width = 436
      Height = 35
      Align = alTop
      Caption = 'Orienta'#231#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Retrato'
        'Paisagem')
      TabOrder = 5
    end
    object pnlModelo: TPanel
      Left = 0
      Top = 45
      Width = 436
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
      object Label3: TLabel
        Left = 18
        Top = 8
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Modelo:'
      end
      object edtCodLay: TEditFocus
        Left = 365
        Top = 2
        Width = 37
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        TabOrder = 1
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cbxModeloPedido: TComboBox
        Left = 59
        Top = 3
        Width = 371
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = cbxModeloPedidoChange
      end
      object cbxModeloBoletim: TComboBox
        Left = 65
        Top = 8
        Width = 371
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        Visible = False
        OnChange = cbxModeloBoletimChange
      end
    end
  end
end
