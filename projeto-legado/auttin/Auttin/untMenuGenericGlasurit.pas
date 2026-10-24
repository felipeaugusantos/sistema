unit untMenuGenericGlasurit;

interface

uses
  untFuncoesSimples, untCadGlaBases, untCadGlaGeraArquivo, untCadGlaNovasFormulas, untConfiguracoesGlasurit,
  SysUtils, Forms, untFuncTinta, untPaiGeraArq, untGlasuritDinamica, Classes;

procedure pCriaFormularioBaseGlasurit(); Stdcall;
procedure pCriaFormularioConfGlasurit(); Stdcall;
procedure pCriaFormularioGerArqGlasurit(); Stdcall;
procedure pCriaFormularioNovasFormulasGlasurit(); Stdcall;
procedure pCriaFormularioGerarNovasFormulasGlasurit(Sender: TComponent); Stdcall;
procedure pConsultaGlasuritGeralDinamica(Sender: TForm); Stdcall;


implementation

procedure pCriaFormularioBaseGlasurit(); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    pCriarFormularios(TfrmCadGlaBases, frmCadGlaBases);
    frmCadGlaBases.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioBaseGlasurit]');
    End;
  End;
  pFreeAndNil(frmCadGlaBases);
End;

procedure pCriaFormularioConfGlasurit(); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    pCriarFormularios(TfrmConfiguracoesGlasurit, frmConfiguracoesGlasurit);
    frmConfiguracoesGlasurit.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioConfGlasurit]');
    End;
  End;
  pFreeAndNil(frmConfiguracoesGlasurit);
End;

procedure pCriaFormularioGerArqGlasurit(); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    pCriarFormularios(TfrmCadGlaGeraArquivo, frmCadGlaGeraArquivo);
    frmCadGlaGeraArquivo.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioGerArqGlasurit]');
    End;
  End;
  pFreeAndNil(frmCadGlaGeraArquivo);
End;

procedure pCriaFormularioNovasFormulasGlasurit(); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    pCriarFormularios(TfrmCadGlaNovasFormulas, frmCadGlaNovasFormulas);
    frmCadGlaNovasFormulas.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioNovasFormulasGlasurit]');
    End;
  End;
  pFreeAndNil(frmCadGlaNovasFormulas);
End;

procedure pCriaFormularioGerarNovasFormulasGlasurit(Sender: TComponent); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    frmPaiGeraArq := TfrmPaiGeraArq.Create(Sender, TGlasuritDinamica);
    frmPaiGeraArq.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioGerarNovasFormulasGlasurit]');
    End;
  End;
  pFreeAndNil(frmPaiGeraArq);
End;

procedure pConsultaGlasuritGeralDinamica(Sender: TForm); Stdcall;
Begin
  Try
    fConsultaGlasuritGeralDinamica(Sender);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pConsultaGlasuritGeralDinamica]');
    End;
  End;
End;

end.
