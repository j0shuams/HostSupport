using System.Collections.Generic;
using System.Linq;
using Microsoft.CodeAnalysis.CSharp.Syntax;

namespace Demo
{
    class Snippet
    {
        /// <summary>
        /// Raises a diagnostic when multiple constructors for a class are defined with the same arity.</summary>
        /// <param name="classDeclaration">Look at constructors of this class</param>
        private void HasMultipleConstructorsOfSameArity(ClassDeclarationSyntax classDeclaration)
        {
            IEnumerable<ConstructorDeclarationSyntax> constructors = classDeclaration.ChildNodes().OfType<ConstructorDeclarationSyntax>()/*.Where(IsPublic)*/;

            HashSet<int> aritiesSeenSoFar = new HashSet<int>();

            foreach (ConstructorDeclarationSyntax constructor in constructors)
            {
                int arity = constructor.ParameterList.Parameters.Count;
                if (aritiesSeenSoFar.Contains(arity))
                {
                    // Really, ClassConstructorRule is a DiagnosticDescriptor
                    // Report adds a diagnostic object to `this` scanner 
                    // Report(WinRTRules.ClassConstructorRule, constructor.GetLocation(), classDeclaration.Identifier, arity);
                }
                else
                {
                    aritiesSeenSoFar.Add(arity);
                }
            }

            /* Not demo'd: semantic symbols, interface examples
            * -- e.g., for the given class declaration, we can see information like what interfaces it implements 
            * -- interfaces get most of the same treatment as classes, classes require more consideration  */
        }
    }
}
