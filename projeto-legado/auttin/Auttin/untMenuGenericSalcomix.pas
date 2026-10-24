unit untMenuGenericSalcomix;

interface

uses
  untFuncoesSimples, untCadSalBases, untCadSalGeraArquivo, untCadSalNovasFormulas, untConfiguracoesSalcomix,
  SysUtils, Forms, untFuncTinta, untPaiGeraArq, untSalcomixDinamica, Classes;

procedure pCriaFormularioBaseSalcomix(); Stdcall;
procedure pCriaFormularioConfSalcomix(); Stdcall;
procedure pCriaFormularioGerArqSalcomix(); Stdcall;
procedure pCriaFormularioNovasFormulasSalcomix(); Stdcall;
procedure pCriaFormularioGerarNovasFormulasSalcomix(Sender: TComponent); Stdcall;
procedure pConsultaSalcomixGeralDinamica(Sender: TForm); Stdcall;


implementation

procedure pCriaFormularioBaseSalcomix(); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    pCriarFormularios(TfrmCadSalBases, frmCadSalBases);
    frmCadSalBases.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioBaseSalcomix]');
    End;
  End;
  pFreeAndNil(frmCadSalBases);
End;

procedure pCriaFormularioConfSalcomix(); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    pCriarFormularios(TfrmConfiguracoesSalcomix, frmConfiguracoesSalcomix);
    frmConfiguracoesSalcomix.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioConfSalcomix]');
    End;
  End;
  pFreeAndNil(frmConfiguracoesSalcomix);
End;

procedure pCriaFormularioGerArqSalcomix(); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    pCriarFormularios(TfrmCadSalGeraArquivo, frmCadSalGeraArquivo);
    frmCadSalGeraArquivo.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioGerArqSalcomix]');
    End;
  End;
  pFreeAndNil(frmCadSalGeraArquivo);
End;

procedure pCriaFormularioNovasFormulasSalcomix(); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    pCriarFormularios(TfrmCadSalNovasFormulas, frmCadSalNovasFormulas);
    frmCadSalNovasFormulas.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioNovasFormulasSalcomix]');
    End;
  End;
  pFreeAndNil(frmCadSalNovasFormulas);
End;

procedure pCriaFormularioGerarNovasFormulasSalcomix(Sender: TComponent); Stdcall;
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    frmPaiGeraArq := TfrmPaiGeraArq.Create(Sender, TSalcomixDinamica);
    frmPaiGeraArq.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaFormularioGerarNovasFormulasGlasurit]');
    End;
  End;
  pFreeAndNil(frmPaiGeraArq);
End;

procedure pConsultaSalcomixGeralDinamica(Sender: TForm); Stdcall;
Begin
  Try
    fConsultaSalcomixGeralDinamica(Sender);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pConsultaSalcomixGeralDinamica]');
    End;
  End;
End;



end.
