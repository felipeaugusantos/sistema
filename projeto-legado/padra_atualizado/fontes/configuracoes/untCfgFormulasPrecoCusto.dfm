inherited frmFormulaCalcPCusto: TfrmFormulaCalcPCusto
  Left = 313
  Top = 286
  Width = 840
  Height = 491
  BorderStyle = bsDialog
  Caption = 'F'#243'rmulas C'#225'lculo Pre'#231'o de Custo'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 840
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 420
    Width = 834
    Height = 26
    ExplicitTop = 420
    ExplicitWidth = 834
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 753
      Height = 22
      ExplicitWidth = 753
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnConfirmaClick
        OnKeyDown = FormKeyDown
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 755
      Top = 2
      Align = alRight
      OnKeyDown = FormKeyDown
      ExplicitLeft = 755
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 446
    Width = 834
    ExplicitTop = 446
    ExplicitWidth = 834
    inherited pnlNomeForm: TPanel
      Left = 663
      ExplicitLeft = 663
    end
    inherited pnlInfo: TPanel
      Width = 663
      ExplicitWidth = 663
    end
  end
  object pagFormulas: TPageControl [2]
    Left = 0
    Top = 0
    Width = 834
    Height = 379
    ActivePage = tbsFormula4
    Align = alClient
    Style = tsButtons
    TabOrder = 3
    object tbsFormula1: TTabSheet
      Caption = 'F'#243'rmula &1'
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 826
        Height = 347
        Align = alClient
        BorderStyle = bsNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Lines.Strings = (
          'F'#211'RMULA N'#186' 1 '
          ''
          'X1 = PRECO DE COMPRA'
          'X2 = (X1 - DESCONTOS)'
          'X2 = X2 + (  X2 * IPI ENTRADA )'
          'X2 = X2 + (  X2 * SUBSTITUICAO )'
          ''
          'RESULTADO_1 = X2 * ICMS DE ENTRADA'
          'RESULTADO_3 = X2 * %FRETE '
          'RESULTADO_4 = X2 * ACRESCIMO FINANCEIRO'
          'RESULTADO_5 = X2 * IMPOSTOS FEDERAIS'
          
            'RESULTADO_6 = X2 - RESULTADO_1 +  RESULTADO_3 + RESULTADO_4 - RE' +
            'SULTADO_5 + VALOR_FRETE '
          'RESULTADO_7 = RESULTADO_6 * DESCONTO ADICIONAL BOLETO'
          ''
          'PRECO DE CUSTO = RESULTADO_6 - RESULTADO_7 '
          ''
          '')
        ParentFont = False
        TabOrder = 0
        Visible = False
        OnKeyDown = FormKeyDown
      end
    end
    object tbsFormula2: TTabSheet
      Caption = 'F'#243'rmula &2'
      ImageIndex = 1
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 826
        Height = 347
        Align = alClient
        BorderStyle = bsNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Lines.Strings = (
          'F'#211'RMULA N'#186' 2 '
          ''
          'X1 = PRECO DE COMPRA'
          'X2 = (X1 - DESCONTOS)'
          'RESULTADO_1 = X2 * IPI DE ENTRADA'
          'RESULTADO_2 = X2 * SUBSTITUICAO'
          ''
          'X_FRETE = X2 + RESULTADO_1 + RESULTADO_2'
          'RESULTADO_3 = X_FRETE * FRETE'
          ''
          'RESULTADO_4 = X2 * ICMS DE ENTRADA'
          
            'RESULTADO_5 =(X2 + RESULTADO_1 +RESULTADO_2) * ACRESCIMO FINANCE' +
            'IRO'
          'RESULTADO_6 = X2 * IMPOSTOS FEDERAIS'
          
            'RESULTADO_7 = X2 + RESULTADO_1 + RESULTADO_2 + RESULTADO_3 - RES' +
            'ULTADO_4 + RESULTADO_5  - RESULTADO_6 + VALOR_FRETE'
          'RESULTADO_8 = RESULTADO_7 * DESCONTO ADICIONAL BOLETO'
          ''
          'PRECO DE CUSTO = RESULTADO_7 - RESULTADO_8 '
          ''
          ''
          '')
        ParentFont = False
        TabOrder = 0
        Visible = False
        OnKeyDown = FormKeyDown
      end
    end
    object tbsFormula3: TTabSheet
      Caption = 'F'#243'rmula &3'
      ImageIndex = 2
      object Memo3: TMemo
        Left = 0
        Top = 0
        Width = 826
        Height = 347
        Align = alClient
        BorderStyle = bsNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Lines.Strings = (
          'F'#211'RMULA N'#186' 3 '
          ''
          'X1 = PRECO DE COMPRA'
          'X2 = (X1 - DESCONTOS)'
          ''
          'RESULTADO_1 = X2 * IPI DE ENTRADA'
          'RESULTADO_2 = X2 * ICMS DE ENTRADA'
          'RESULTADO_3 = X2 * FRETE_ENTRADA'
          'RESULTADO_4 = X2 * ACRESCIMO FINANCEIRO'
          'RESULTADO_5 = (X2 + RESULTADO_1 + RESULTADO_3) * SUBSTITUICAO'
          'RESULTADO_6 = X2 * IMPOSTOS FEDERAIS'
          
            'RESULTADO_7 = X2 + RESULTADO_1 - RESULTADO_2 + RESULTADO_3 + RES' +
            'ULTADO_4 + RESULTADO_5 - RESULTADO_6 + VALOR_FRETE'
          'RESULTADO_8 = RESULTADO_7 * DESCONTO ADICIONAL BOLETO'
          ''
          'PRECO DE CUSTO = RESULTADO_7 - RESULTADO_8 ')
        ParentFont = False
        TabOrder = 0
        Visible = False
        OnKeyDown = FormKeyDown
      end
    end
    object tbsFormula4: TTabSheet
      Caption = 'F'#243'rmula &4'
      ImageIndex = 3
    end
  end
  object pnlTail: TPanel [3]
    Left = 0
    Top = 379
    Width = 834
    Height = 41
    Align = alBottom
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 2
    object lblTipoFormula: TColorLabel
      Left = 8
      Top = 13
      Width = 375
      Height = 14
      Caption = 
        'Digite o tipo de f'#243'rmula usada para o c'#225'lculo de pre'#231'o de custo ' +
        '(1, 2, 3 ou 4) :'
      CorDestaque = clRed
    end
    object edtTipoFormula: TEditFocus
      Left = 386
      Top = 7
      Width = 22
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 1
      TabOrder = 0
      OnKeyDown = edtTipoFormulaKeyDown
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 448
    Top = 80
  end
end
