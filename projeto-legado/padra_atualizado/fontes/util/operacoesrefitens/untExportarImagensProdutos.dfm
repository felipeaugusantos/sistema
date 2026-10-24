inherited frmExportarImagensProdutos: TfrmExportarImagensProdutos
  Width = 545
  Height = 400
  Caption = 'Exporta'#231#227'o Imagens Produtos'
  ExplicitWidth = 545
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 329
    Width = 539
    ExplicitTop = 329
    ExplicitWidth = 539
    inherited FlwBotoes: TFlowPanel
      Width = 535
      ExplicitWidth = 535
    end
    inherited btnSair: TBitBtnLocked
      Left = 459
      ExplicitLeft = 459
    end
  end
  inherited pnlStatus: TPanel
    Top = 355
    Width = 539
    ExplicitTop = 355
    ExplicitWidth = 539
    inherited pnlNomeForm: TPanel
      Left = 368
      ExplicitLeft = 368
    end
    inherited pnlInfo: TPanel
      Width = 368
      ExplicitWidth = 368
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 539
    Height = 329
    Align = alClient
    TabOrder = 2
    object pnlCaminhoExportacao: TPanel
      Left = 1
      Top = 256
      Width = 537
      Height = 66
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 5
      TabOrder = 0
      object cxGbCaminhoExportacao: TcxGroupBox
        Left = 5
        Top = 5
        Align = alClient
        Caption = 'Caminho para exporta'#231#227'o das imagens:'
        TabOrder = 0
        Height = 56
        Width = 527
        object lblSelecionarCaminho: TLabel
          Left = 15
          Top = 26
          Width = 50
          Height = 14
          Caption = 'Selecione:'
        end
        object spbAbrirSelecaoCaminho: TSpeedButton
          Left = 496
          Top = 22
          Width = 21
          Height = 19
          Cursor = crHandPoint
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000090000
            000E000000100000001000000010000000100000001000000011000000110000
            001100000011000000100000000B00000003000000000000000019427ACA245A
            A5FF255CA7FF255BA7FF245AA6FF2459A6FF2358A5FF2358A4FF2356A4FF2256
            A4FF2255A3FF2154A3FF2153A1FF1C468AE303080F2900000002255DA5FF316B
            AEFF6DA6D5FF86CAF0FF46A6E4FF44A3E4FF41A1E3FF3FA0E2FF3C9EE2FF3B9C
            E1FF389BE0FF369AE0FF3498DFFF2C77C1FF10284D8B000000082B68AEFF4984
            BEFF4B8BC5FFB2E3F8FF68BBECFF55B0E8FF52AEE8FF4EACE7FF4CA9E6FF49A8
            E5FF47A6E4FF44A4E4FF41A2E3FF3A92D6FF1C4885D50000000D2F6FB4FF6CA7
            D2FF3F87C4FFAED9F0FF9AD8F5FF66BDEEFF63BBEDFF60B9EBFF5DB6EBFF5BB5
            EAFF57B2EAFF55B0E9FF51AEE7FF4FABE7FF2D69B1FF040B142F3276B9FF8FC7
            E6FF509FD4FF86BCE0FFC5EFFCFF78CAF2FF74C8F1FF72C5F0FF6FC4F0FF6DC2
            EFFF69C0EEFF66BDEEFF63BBEDFF60B9EBFF448BC9FF122D4D81357CBCFFAFE3
            F5FF75C8EDFF59A2D4FFDDF7FDFFDFF8FEFFDDF7FEFFDBF7FEFFD8F5FEFFD4F4
            FDFFD0F2FDFFCCEFFCFFC7EDFBFFC1EBFBFF9ACBE9FF215187CB3882C1FFC7F5
            FEFF97E5FCFF64BAE5FF4D9FD3FF4D9DD2FF4B9BD1FF4A99CFFF4998CFFF4896
            CEFF4694CCFF4592CBFF3073B7FF3072B6FF2F71B5FF2A65A4EA3A88C5FFCDF7
            FEFFA6ECFEFF9CE8FDFF93E4FBFF8EE1FBFF89DFFBFF86DEFAFF81DAFAFF7ED8
            F9FF7BD7F9FF79D6F9FF2A6BB0FF000000140000000A000000073D8EC8FFD0F8
            FEFFAEF0FEFFAAEEFEFFA6EDFEFFA5EBFDFFBBF2FDFFD4F9FEFFD5F9FEFFD3F8
            FEFFD1F8FEFFCEF7FDFF3680BFFF0000000800000000000000003F92CBFFD3F9
            FEFFB6F3FEFFB3F1FDFFB0F1FEFFB8EDFAFF4895CBFF3B8CC6FF3B8AC6FF3A89
            C5FF3A88C5FF3A87C3FF2A6391C20000000500000000000000004197CEFFE2FC
            FEFFE2FCFEFFE1FCFEFFD4F3FAFF458FBFEC040A0E1B00000006000000060000
            000600000006000000060000000400000001000000000000000031739ABF429A
            D0FF4299D0FF4299D0FF4297CFFF153244590000000200000000000000000000
            0000000000000000000000000000000000000000000000000000000000020000
            0003000000030000000400000003000000020000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          OnClick = spbAbrirSelecaoCaminhoClick
        end
        object edtCaminhoExportacao: TEditFocus
          Left = 67
          Top = 22
          Width = 426
          Height = 20
          Alignment = taLeftJustify
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
          Text = 'C:\'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object pnlFiltros: TPanel
      Left = 1
      Top = 1
      Width = 537
      Height = 255
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 5
      TabOrder = 1
      object cxGbFiltros: TcxGroupBox
        Left = 5
        Top = 5
        Align = alClient
        Caption = 'Filtros'
        TabOrder = 0
        Height = 245
        Width = 527
        object lblCodProduto: TLabel
          Left = 61
          Top = 19
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cod. Produto:'
        end
        object lblDescricao: TLabel
          Left = 74
          Top = 51
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o:'
        end
        object lblLinhaGrupo: TLabel
          Left = 64
          Top = 83
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha/Grupo:'
        end
        object lblDepartamento: TLabel
          Left = 56
          Top = 115
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento:'
        end
        object lblUnidade: TLabel
          Left = 84
          Top = 147
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
        end
        object lblFornecedor: TLabel
          Left = 67
          Top = 179
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
        end
        object lblGrupoProdutos: TLabel
          Left = 32
          Top = 211
          Width = 94
          Height = 14
          Alignment = taRightJustify
          Caption = 'Grupo de Produtos:'
        end
        object edtCodProdutoDescricao: TEditFocus
          Left = 196
          Top = 16
          Width = 240
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodProdutoCodigo: TEditFocus
          Tag = 99
          Left = 132
          Top = 16
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          ParentCtl3D = False
          TabOrder = 1
          OnExit = edtCodProdutoCodigoExit
          OnKeyPress = edtCodProdutoCodigoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
        object edtDescricao: TEditFocus
          Tag = 99
          Left = 132
          Top = 48
          Width = 304
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 255
          ParentCtl3D = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 30
          TipoTexto = ttAlfanumerico
        end
        object edtLinhaGrupoDescricao: TEditFocus
          Left = 196
          Top = 80
          Width = 240
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtLinhaGrupoCodigo: TEditFocus
          Tag = 99
          Left = 132
          Top = 80
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          ParentCtl3D = False
          TabOrder = 4
          OnExit = edtLinhaGrupoCodigoExit
          OnKeyPress = edtLinhaGrupoCodigoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttAlfanumerico
        end
        object edtDepartamentoDescricao: TEditFocus
          Left = 196
          Top = 112
          Width = 240
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtDepartamentoCodigo: TEditFocus
          Tag = 99
          Left = 132
          Top = 112
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentCtl3D = False
          TabOrder = 6
          OnExit = edtDepartamentoCodigoExit
          OnKeyPress = edtDepartamentoCodigoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtUnidadeDescricao: TEditFocus
          Left = 196
          Top = 144
          Width = 240
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtUnidadeCodigo: TEditFocus
          Tag = 99
          Left = 132
          Top = 144
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentCtl3D = False
          TabOrder = 8
          OnExit = edtUnidadeCodigoExit
          OnKeyPress = edtUnidadeCodigoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtFornecedorDescricao: TEditFocus
          Left = 196
          Top = 176
          Width = 240
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtFornecedorCodigo: TEditFocus
          Tag = 99
          Left = 132
          Top = 176
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          ParentCtl3D = False
          TabOrder = 10
          OnExit = edtFornecedorCodigoExit
          OnKeyPress = edtFornecedorCodigoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttAlfanumerico
        end
        object edtGrupoProdutosDescricao: TEditFocus
          Left = 196
          Top = 208
          Width = 240
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtGrupoProdutosCodigo: TEditFocus
          Tag = 99
          Left = 132
          Top = 208
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentCtl3D = False
          TabOrder = 12
          OnExit = edtGrupoProdutosCodigoExit
          OnKeyPress = edtGrupoProdutosCodigoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 112
  end
end
