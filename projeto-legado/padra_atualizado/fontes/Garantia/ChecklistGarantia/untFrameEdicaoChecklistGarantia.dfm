object fraEdicaoChecklistGarantia: TfraEdicaoChecklistGarantia
  Left = 0
  Top = 0
  Width = 1010
  Height = 160
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlChkGarPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 1010
    Height = 160
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlChkGarPrincipal'
    TabOrder = 0
    object lblTituloChecklist: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 4
      Width = 1004
      Height = 19
      Margins.Top = 4
      Align = alTop
      Alignment = taCenter
      Caption = 'CHECKLIST PARA TROCA DE MERCADORIA E/OU DEVOLU'#199#195'O EM GARANTIA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 606
    end
    object pnlChkGarPrincipal1: TPanel
      Left = 0
      Top = 23
      Width = 1010
      Height = 46
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlChkGarPrincipal1'
      ShowCaption = False
      TabOrder = 0
      object lblChkGarDescri: TLabel
        Left = 191
        Top = 12
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object lblChkGarCodigo: TLabel
        Left = 3
        Top = 13
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object edtChkGarCodigo: TEditFocus
        Tag = 99
        Left = 46
        Top = 10
        Width = 121
        Height = 21
        Alignment = taLeftJustify
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        OnKeyDown = edtChkGarCodigoKeyDown
        OnKeyPress = edtChkGarCodigoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtChkGarDescricao: TEditFocus
        Tag = 99
        Left = 247
        Top = 10
        Width = 474
        Height = 21
        Alignment = taLeftJustify
        Color = 16770261
        Enabled = False
        ReadOnly = True
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
    object pnlChkGarPrincipal2: TPanel
      Left = 0
      Top = 69
      Width = 1010
      Height = 91
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlChkGarPrincipal2'
      ShowCaption = False
      TabOrder = 1
      object Panel17: TPanel
        Left = 0
        Top = 0
        Width = 385
        Height = 91
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'pnlChkGarPrincipal2Esq'
        ShowCaption = False
        TabOrder = 0
        object rdgChkGarTipoVG: TRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 221
          Height = 85
          Margins.Left = 4
          Align = alLeft
          Caption = 'Grupo'
          Enabled = False
          Items.Strings = (
            'Valida'#231#227'o de garantia de mercadoria'
            'Valida'#231#227'o de troca de mercadoria')
          TabOrder = 0
        end
        object rdgChkGarTipoRE: TRadioGroup
          AlignWithMargins = True
          Left = 231
          Top = 3
          Width = 151
          Height = 85
          Align = alClient
          Caption = 'Tipo'
          Enabled = False
          Items.Strings = (
            'Linha '#250'nica'
            'M'#250'ltiplas Linhas'
            'N/A')
          TabOrder = 1
        end
      end
      object pnlChkGarPrincipal2Dir: TPanel
        Left = 385
        Top = 0
        Width = 625
        Height = 91
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlChkGarPrincipal2Dir'
        ShowCaption = False
        TabOrder = 1
        object lblChkGarCarateresMemo: TLabel
          Left = 10
          Top = 74
          Width = 127
          Height = 13
          Caption = 'Caracteres restantes: 256'
        end
        object lblchkGarConteudo: TLabel
          AlignWithMargins = True
          Left = 8
          Top = 1
          Width = 51
          Height = 13
          Margins.Left = 10
          Alignment = taRightJustify
          Caption = 'Conte'#250'do:'
        end
        object mmoChkGarConteudo: TMemoFocus
          Left = 10
          Top = 17
          Width = 432
          Height = 57
          Align = alCustom
          CharCase = ecUpperCase
          Enabled = False
          MaxLength = 256
          TabOrder = 0
          OnChange = mmoChkGarConteudoChange
          OnKeyPress = mmoChkGarConteudoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object btnChkGarConfirmar: TBitBtnLocked
          Left = 448
          Top = 48
          Width = 75
          Height = 25
          Caption = 'Confirmar'
          Enabled = False
          TabOrder = 1
          OnClick = btnChkGarConfirmarClick
        end
        object btnChkGarCancelar: TBitBtnLocked
          Left = 528
          Top = 48
          Width = 75
          Height = 25
          Caption = 'Cancelar'
          Enabled = False
          TabOrder = 2
          OnClick = btnChkGarCancelarClick
        end
      end
    end
  end
end
